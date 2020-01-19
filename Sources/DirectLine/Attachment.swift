import Foundation

/// Defines additional information to include in the message.
public enum Attachment: Equatable {
    case url(URLAttachment)
    case content(ContentAttachment)
}

extension Attachment: Codable {
    private enum CodingKeys: String, CodingKey {
        case contentURL = "contentUrl"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if (try container.decodeIfPresent(URL.self, forKey: .contentURL)) != nil {
            self = try .url(URLAttachment(from: decoder))
        } else {
            self = try .content(ContentAttachment(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .url(attachment):
            try attachment.encode(to: encoder)
        case let .content(attachment):
            try attachment.encode(to: encoder)
        }
    }
}
