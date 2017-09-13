import Foundation

/// A Direct Line conversation.
public struct Conversation {

	/// Uniquely identifies the conversation for which the specified token is valid.
	public let conversationId: String

	/// URL for the conversation's activity stream.
	public let streamURL: URL

	/// Token that is valid for the specified conversation.
	public var token: Token

	func with(token newToken: Token) -> Conversation {
		return Conversation(conversationId: conversationId, streamURL: streamURL, token: newToken)
	}
}

extension Conversation: Decodable {
	private enum CodingKeys: String, CodingKey {
		case conversationId
		case streamURL = "streamUrl"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let conversationId = try container.decode(String.self, forKey: .conversationId)
		let streamURL = try container.decode(URL.self, forKey: .streamURL)
		let token = try Token(from: decoder)

		self.init(conversationId: conversationId, streamURL: streamURL, token: token)
	}
}
