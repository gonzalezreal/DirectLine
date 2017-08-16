import Foundation

/// Defines a conversation in a channel.
public struct ConversationAccount {

	/// The ID that identifies the conversation.
	public let id: String

	/// Flag to indicate whether or not this is a group conversation.
	public let isGroup: Bool

	/// A display name that can be used to identify the conversation.
	public let name: String?
}

extension ConversationAccount: Decodable {
	private enum CodingKeys: CodingKey {
		case id, isGroup, name
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let id = try container.decode(String.self, forKey: .id)
		let isGroup = try container.decodeIfPresent(Bool.self, forKey: .isGroup) ?? false
		let name = try container.decodeIfPresent(String.self, forKey: .name)

		self.init(id: id, isGroup: isGroup, name: name)
	}
}
