import Foundation

/// A Direct Line conversation.
public struct Conversation: Decodable {

	/// Uniquely identifies the conversation for which the specified token is valid.
	public let conversationId: String

	/// Token that is valid for the specified conversation.
	public let token: String

	/// Number of seconds until the token expires.
	public let expiresIn: TimeInterval

	/// URL for the conversation's message stream.
	public let streamURL: URL?

	private enum CodingKeys: String, CodingKey {
		case conversationId
		case token
		case expiresIn = "expires_in"
		case streamURL = "streamUrl"
	}
}
