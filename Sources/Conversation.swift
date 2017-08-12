import Foundation

public struct Conversation: Decodable {
	public let conversationId: String
	public let token: String
	public let expiresIn: TimeInterval
	public let streamURL: URL

	private enum CodingKeys: String, CodingKey {
		case conversationId
		case token
		case expiresIn = "expires_in"
		case streamURL = "streamUrl"
	}
}
