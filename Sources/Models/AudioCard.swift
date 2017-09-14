import Foundation

/// Defines a card that can play an audio file.
public struct AudioCard {
	internal static let contentType = "application/vnd.microsoft.card.audio"

	/// Aspect ratio of the thumbnail that is specified in the image property.
	///
	/// Valid values are 16:9 and 9:16.
	public let aspect: String?

	/// Flag that indicates whether to replay the list of audio files when the last one ends.
	public let autoloop: Bool

	/// Flag that indicates whether to automatically play the audio when the card is displayed.
	public let autostart: Bool

	/// Array of `CardAction` values that enable the user to perform one or more actions.
	public let buttons: [CardAction]

	/// A `ThumbnailURL` value that specifies the image to display on the card.
	public let image: ThumbnailURL?

	/// Array of `MediaURL` values that specifies the list of audio files to play.
	public let media: [MediaURL]

	/// Flag that indicates whether the audio files may be shared with others.
	public let isShareable: Bool

	/// Subtitle to display under the card's title.
	public let subtitle: String?

	/// Description or prompt to display under the card's title or subtitle.
	public let text: String?

	/// Title of the card.
	public let title: String?
}

extension AudioCard: Decodable {
	private enum CodingKeys: String, CodingKey {
		case aspect
		case autoloop
		case autostart
		case buttons
		case image
		case media
		case shareable
		case subtitle
		case text
		case title
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let aspect = try container.decodeIfPresent(String.self, forKey: .aspect)
		let autoloop = try container.decodeIfPresent(Bool.self, forKey: .autoloop) ?? true
		let autostart = try container.decodeIfPresent(Bool.self, forKey: .autostart) ?? true
		let buttons = try container.decode([CardAction].self, forKey: .buttons)
		let image = try container.decodeIfPresent(ThumbnailURL.self, forKey: .image)
		let media = try container.decode([MediaURL].self, forKey: .media)
		let isShareable = try container.decodeIfPresent(Bool.self, forKey: .shareable) ?? true
		let subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
		let text = try container.decodeIfPresent(String.self, forKey: .text)
		let title = try container.decodeIfPresent(String.self, forKey: .title)

		self.init(aspect: aspect,
		          autoloop: autoloop,
		          autostart: autostart,
		          buttons: buttons,
		          image: image,
		          media: media,
		          isShareable: isShareable,
		          subtitle: subtitle,
		          text: text,
		          title: title)
	}
}
