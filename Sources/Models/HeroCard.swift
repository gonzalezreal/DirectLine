import Foundation

/// Defines a card with a large image, title, text, and action buttons.
public struct HeroCard: Decodable {
	internal static let contentType = "application/vnd.microsoft.card.hero"

	/// Array of `CardAction` values that enable the user to perform one or more actions.
	public let buttons: [CardAction]

	/// Array of `CardImage` values that specifies the image to display on the card.
	public let images: [CardImage]

	/// Subtitle to display under the card's title.
	public let subtitle: String?

	/// A `CardAction` value that specifies the action to perform if the user taps or clicks the card.
	public let tap: CardAction?

	/// Description or prompt to display under the card's title or subtitle.
	public let text: String?

	/// Title of the card.
	public let title: String?
}
