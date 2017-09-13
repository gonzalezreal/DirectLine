import Foundation

/// Defines an image to display on a card.
public struct CardImage: Decodable {

	/// Description of the image.
	public let description: String?

	/// A `CardAction` value that specifies the action to perform if the user taps or clicks the image.
	public let tap: CardAction?

	/// URL to the source of the image.
	public let url: URL

	private enum CodingKeys: String, CodingKey {
		case description = "alt"
		case tap
		case url
	}
}
