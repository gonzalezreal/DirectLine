import Foundation

public struct Token: Decodable {
	public let value: String

	/// Number of seconds until the token expires.
	public let expiresIn: TimeInterval

	private enum CodingKeys: String, CodingKey {
		case value = "token"
		case expiresIn = "expires_in"
	}
}
