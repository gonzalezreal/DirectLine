import Foundation

/// A Direct Line conversation.
public struct Conversation {

	/// Uniquely identifies the conversation for which the specified token is valid.
	public let id: String

	/// URL for the conversation's activity stream.
	public let streamURL: URL

	/// Token that is valid for the specified conversation.
	public var token: Token
}

extension Conversation: Decodable {
	private enum CodingKeys: String, CodingKey {
		case conversationId
		case streamUrl
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let id = try container.decode(String.self, forKey: .conversationId)
		let streamURL = try container.decode(URL.self, forKey: .streamUrl)
		let token = try Token(from: decoder)

		self.init(id: id, streamURL: streamURL, token: token)
	}
}
