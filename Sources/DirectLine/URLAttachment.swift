import Foundation

public struct URLAttachment: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case contentType, name
        case contentURL = "contentUrl"
        case thumbnailURL = "thumbnailUrl"
    }

    /// The media type of the content in the attachment.
    public let contentType: String

    /// URL for the content of the attachment.
    public let contentURL: URL

    /// Name of the attachment.
    public let name: String?

    /// Thumbnail image for the attachment.
    public let thumbnailURL: URL?
}
