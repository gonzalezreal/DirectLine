import Foundation

/**
	Defines additional information to include in the message.

	An attachment may be a media file (e.g., audio, video, image, file) or a rich card.
*/
public struct Attachment: Codable {
	public enum Content {
		case media(Media)
	}

	/// The content of the attachment.
	public let content: Content

	/// Name of the attachment.
	public let name: String

	/// URL to a thumbnail image representing an alternative, smaller form of content.
	public let thumbnailURL: URL?

	private enum CodingKeys: String, CodingKey {
		case contentType
		case content
		case name
		case thumbnailURL = "thumbnailUrl"
	}
}

public extension Attachment {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let contentType = try container.decode(String.self, forKey: .contentType)
		let content: Content

		switch contentType {
		default:
			content = .media(try Media(from: decoder))
		}

		let name = try container.decode(String.self, forKey: .name)
		let thumbnailURL = try container.decodeIfPresent(URL.self, forKey: .thumbnailURL)

		self.init(content: content, name: name, thumbnailURL: thumbnailURL)
	}

	func encode(to encoder: Encoder) throws {
		fatalError()
	}
}
