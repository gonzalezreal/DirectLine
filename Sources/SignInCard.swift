import Foundation

/// Defines a card that lets a user sign in to a service.
public struct SignInCard: Decodable {
	internal static let contentType = "application/vnd.microsoft.com.card.signin"

	/// Array of `CardAction` values  that enable the user to sign in to a service.
	public let buttons: [CardAction]

	/// Description or prompt to include on the sign in card.
	public let text: String?
}
