import Foundation

/// Defines a card that contains a receipt for a purchase.
public struct ReceiptCard: Decodable {
	internal static let contentType = "application/vnd.microsoft.com.card.receipt"

	/// Array of `CardAction` values that enable the user to perform one or more actions.
	public let buttons: [CardAction]

	/// Array of `Fact` values that specify information about the purchase.
	///
	/// For example, the list of facts for a hotel stay receipt might include
	/// the check-in date and check-out date.
	public let facts: [Fact]

	/// Array of `ReceiptItem` values that specify the purchased items.
	public let items: [ReceiptItem]

	/// A `CardAction` value that specifies the action to perform if the user taps or clicks the card.
	public let tap: CardAction?

	/// A currency-formatted string that specifies the amount of tax applied to the purchase.
	public let tax: String?

	/// Title displayed at the top of the receipt.
	public let title: String?

	/// A currency-formatted string that specifies the total purchase price, including all applicable taxes.
	public let total: String?

	/// A currency-formatted string that specifies the amount of value added tax (VAT) applied to the purchase price.
	public let vat: String?
}
