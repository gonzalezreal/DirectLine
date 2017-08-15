import Foundation

/// Defines a line item within a receipt.
public struct ReceiptItem: Decodable {

	/// A `CardImage` value that specifies thumbnail image to display next to the line item.
	public let image: CardImage?

	/// A currency-formatted string that specifies the total price of all units purchased.
	public let price: String?

	/// A numeric string that specifies the number of units purchased.
	public let quantity: String?

	/// Subtitle to be displayed under the line item’s title.
	public let subtitle: String?

	/// A `CardAction` value that specifies the action to perform if the user taps or clicks the line item.
	public let tap: CardAction?

	/// Description of the line item.
	public let text: String?

	/// Title of the line item.
	public let title: String?
}
