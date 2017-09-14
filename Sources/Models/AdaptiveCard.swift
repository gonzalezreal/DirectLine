import Foundation

/// WIP
public struct AdaptiveCard: Decodable {
	internal static let contentType = "application/vnd.microsoft.card.adaptive"

	public let type: String

	internal init() {
		type = "AdaptiveCard"
	}
}
