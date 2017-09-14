import Foundation

/// Defines an image to display on a card.
public struct CardImage: Decodable {

	/// URL to the source of the image.
	public let url: URL

	/// A `CardAction` value that specifies the action to perform if the user taps or clicks the image.
	public let tap: CardAction?

	/// Description of the image.
	public let description: String?

	private enum CodingKeys: String, CodingKey {
		case url
		case tap
		case description = "alt"
	}
}
