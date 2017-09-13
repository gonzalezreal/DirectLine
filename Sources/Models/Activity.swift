import Foundation

public enum AttachmentLayout: String, Decodable {
	case carousel, list
}

public enum InputHint: String, Decodable {
	case acceptingInput, expectingInput, ignoringInput
}

public enum TextFormat: String, Codable {
	case markdown, plain, xml
}

/// Activity types.
///
/// - message: Represents a communication between bot and user.
/// - conversationUpdate: Indicates that the bot was added to a conversation,
///   other members were added to or removed from the conversation,
///   or conversation metadata has changed.
/// - contactRelationUpdate: Indicates that the bot was added or removed from a user's contact list.
/// - typing: Indicates that the user or bot on the other end of the conversation is compiling a response.
/// - ping: Represents an attempt to determine whether a bot's endpoint is accessible.
/// - deleteUserData: Indicates to a bot that a user has requested that the bot delete any user data it may have stored.
/// - endOfConversation: Indicates the end of a conversation.
public enum ActivityType: String, Codable {
	case message
	case conversationUpdate
	case contactRelationUpdate
	case typing
	case ping
	case deleteUserData
	case endOfConversation
}

/// Defines a message that is exchanged between bot and user.
public struct Activity {

	/// Array of `Attachment` values that defines additional information to include in the message.
	public let attachments: [Attachment]

	/// Layout of the rich card attachments that the message includes.
	public let attachmentLayout: AttachmentLayout?

	/// An ID that uniquely identifies the channel. Set by the channel.
	public let channelId: String?

	/// A `ConversationAccount` value that defines the conversation to which the activity belongs.
	public let conversation: ConversationAccount?

	/// A `ChannelAccount` value that specifies the sender of the message.
	public let from: ChannelAccount

	/// ID that uniquely identifies the activity on the channel. Can be `nil` when the activity
	/// is created by the user.
	public let id: String?

	/// Value that indicates whether your bot is accepting, expecting, or ignoring
	/// user input after the message is delivered to the client.
	public let inputHint: InputHint?

	/// Locale of the language that should be used to display text within the message.
	public let locale: Locale?

	/// Text to be spoken by your bot on a speech-enabled channel.
	public let speak: String?

	/// A `SuggestedActions` value that defines the options from which the user can choose.
	public let suggestedActions: SuggestedActions?

	/// Text of the message that is sent from user to bot or bot to user.
	public let text: String?

	/// Format of the message's `text`.
	public let textFormat: TextFormat?

	/// Date and time that the message was sent in the UTC time zone.
	public let timestamp: Date?

	/// Type of activity.
	public let type: ActivityType

	public init(from: ChannelAccount, text: String) {
		self.attachments = []
		self.attachmentLayout = nil
		self.channelId = nil
		self.conversation = nil
		self.from = from
		self.id = nil
		self.inputHint = nil
		self.locale = Locale.current
		self.speak = nil
		self.suggestedActions = nil
		self.text = text
		self.textFormat = nil
		self.timestamp = nil
		self.type = .message
	}
}

extension Activity: Codable {
	private enum CodingKeys: String, CodingKey {
		case attachments
		case attachmentLayout
		case channelId
		case conversation
		case from
		case id
		case inputHint
		case locale
		case speak
		case suggestedActions
		case text
		case textFormat
		case timestamp
		case type
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		attachments = try container.decodeIfPresent([Attachment].self, forKey: .attachments) ?? []
		attachmentLayout = try container.decodeIfPresent(AttachmentLayout.self, forKey: .attachmentLayout)
		channelId = try container.decodeIfPresent(String.self, forKey: .channelId)
		conversation = try container.decodeIfPresent(ConversationAccount.self, forKey: .conversation)
		from = try container.decode(ChannelAccount.self, forKey: .from)
		id = try container.decodeIfPresent(String.self, forKey: .id)
		inputHint = try container.decodeIfPresent(InputHint.self, forKey: .inputHint)
		locale = try container.decodeIfPresent(Locale.self, forKey: .locale)
		speak = try container.decodeIfPresent(String.self, forKey: .speak)
		suggestedActions = try container.decodeIfPresent(SuggestedActions.self, forKey: .suggestedActions)
		text = try container.decodeIfPresent(String.self, forKey: .text)
		textFormat = try container.decodeIfPresent(TextFormat.self, forKey: .textFormat)
		timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp)
		type = try container.decode(ActivityType.self, forKey: .type)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(attachments, forKey: .attachments)
		try container.encode(from, forKey: .from)
		try container.encodeIfPresent(text, forKey: .text)
		try container.encodeIfPresent(textFormat, forKey: .textFormat)
		try container.encode(type, forKey: .type)
	}
}
