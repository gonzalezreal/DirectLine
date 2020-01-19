import Foundation

public struct ContentAttachment {
    /// The media type of the content in the attachment.
    public let contentType: String

    /// The content of the attachment.
    public let content: Any?

    /// Name of the attachment.
    public let name: String?

    /// Thumbnail image for the attachment.
    public let thumbnailURL: URL?
}

extension ContentAttachment: Codable {
    private enum CodingKeys: String, CodingKey {
        case contentType, content, name
        case thumbnailURL = "thumbnailUrl"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        contentType = try container.decode(String.self, forKey: .contentType)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        thumbnailURL = try container.decodeIfPresent(URL.self, forKey: .thumbnailURL)

        if let decode = Self.decoders[contentType] {
            content = try decode(container)
        } else {
            content = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(contentType, forKey: .contentType)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(thumbnailURL, forKey: .thumbnailURL)

        if let content = self.content {
            guard let encode = Self.encoders[contentType] else {
                let context = EncodingError.Context(codingPath: [], debugDescription: "Invalid attachment: \(contentType).")
                throw EncodingError.invalidValue(self, context)
            }

            try encode(content, &container)
        } else {
            try container.encodeNil(forKey: .content)
        }
    }

    // MARK: Registration

    private typealias AttachmentDecoder = (KeyedDecodingContainer<CodingKeys>) throws -> Any
    private typealias AttachmentEncoder = (Any, inout KeyedEncodingContainer<CodingKeys>) throws -> Void
    private typealias EqualityComparer = (Any?, Any?) -> Bool

    private static var decoders: [String: AttachmentDecoder] = [:]
    private static var encoders: [String: AttachmentEncoder] = [:]
    private static var equalityComparers: [String: EqualityComparer] = [:]

    public static func register<T>(_: T.Type, contentType: String) where T: Codable, T: Equatable {
        decoders[contentType] = { container in
            try container.decode(T.self, forKey: .content)
        }

        encoders[contentType] = { content, container in
            try container.encode(content as! T, forKey: .content)
        }

        equalityComparers[contentType] = { l, r in
            guard let lhs = l as? T? else { return false }
            guard let rhs = r as? T? else { return false }
            return lhs == rhs
        }
    }
}

extension ContentAttachment: Equatable {
    public static func == (lhs: ContentAttachment, rhs: ContentAttachment) -> Bool {
        guard lhs.contentType == rhs.contentType else { return false }
        guard lhs.name == rhs.name else { return false }
        guard lhs.thumbnailURL == rhs.thumbnailURL else { return false }
        guard let equalityComparer = Self.equalityComparers[lhs.contentType] else { return false }

        return equalityComparer(lhs.content, rhs.content)
    }
}
