import Foundation

/// Defines additional information to include in the message.
///
/// An attachment may be a media file (e.g., audio, video, image, file) or a rich card.
public struct Attachment {
	public enum Content {
		case adaptiveCard(AdaptiveCard)
		case animationCard(AnimationCard)
		case audioCard(AudioCard)
		case videoCard(VideoCard)
		case heroCard(HeroCard)
		case thumbnailCard(ThumbnailCard)
		case receiptCard(ReceiptCard)
		case media(Media)
		case unknown
	}

	/// The content of the attachment.
	public let content: Content

	/// Name of the attachment.
	public let name: String?

	/// URL to a thumbnail image representing an alternative, smaller form of content.
	public let thumbnailURL: URL?

	public init(content: Content, name: String? = nil, thumbnailURL: URL? = nil) {
		self.content = content
		self.name = name
		self.thumbnailURL = thumbnailURL
	}
}

extension Attachment: Codable {
	private enum CodingKeys: String, CodingKey {
		case contentType
		case content
		case name
		case thumbnailURL = "thumbnailUrl"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let contentType = try container.decode(String.self, forKey: .contentType)
		let content: Content

		switch contentType {
		case AdaptiveCard.contentType:
			content = .adaptiveCard(try container.decode(AdaptiveCard.self, forKey: .content))
		case AnimationCard.contentType:
			content = .animationCard(try container.decode(AnimationCard.self, forKey: .content))
		case AudioCard.contentType:
			content = .audioCard(try container.decode(AudioCard.self, forKey: .content))
		case VideoCard.contentType:
			content = .videoCard(try container.decode(VideoCard.self, forKey: .content))
		case HeroCard.contentType:
			content = .heroCard(try container.decode(HeroCard.self, forKey: .content))
		case ThumbnailCard.contentType:
			content = .thumbnailCard(try container.decode(ThumbnailCard.self, forKey: .content))
		case ReceiptCard.contentType:
			content = .receiptCard(try container.decode(ReceiptCard.self, forKey: .content))
		default:
			if container.contains(.content) {
				content = .unknown
			} else {
				content = .media(try Media(from: decoder))
			}
		}

		let name = try container.decodeIfPresent(String.self, forKey: .name)
		let thumbnailURL = try container.decodeIfPresent(URL.self, forKey: .thumbnailURL)

		self.init(content: content, name: name, thumbnailURL: thumbnailURL)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		switch content {
		case .media(let value):
			try value.encode(to: encoder)
		default:
			let context = EncodingError.Context(codingPath: [CodingKeys.content],
			                                    debugDescription: "This content cannot be encoded.")
			throw EncodingError.invalidValue(content, context)
		}

		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(thumbnailURL, forKey: .thumbnailURL)
	}
}
