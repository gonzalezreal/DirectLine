//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

/// Defines a message that is exchanged between bot and user.
public struct Activity<ChannelData: Codable>: Codable {
	/// Array of `Attachment` values that defines additional information to include in the message.
	public let attachments: [Attachment]

	/// Layout of the rich card attachments that the message includes.
	public let attachmentLayout: AttachmentLayout?

	/// A value that contains channel-specific content.
	public let channelData: ChannelData?

	/// A `ChannelAccount` value that specifies the sender of the message.
	public let from: ChannelAccount

	/// Uniquely identifies the activity on the channel
	public let id: String

	/// Value that indicates whether your bot is accepting, expecting, or ignoring
	/// user input after the message is delivered to the client.
	public let inputHint: InputHint?

	/// Locale of the language that should be used to display text within the message.
	public let locale: String?

	/// The identifier of the message to which this message replies.
	public let replyToId: String?

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

	// MARK: - Codable

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		if attachments.count > 0 {
			try container.encode(attachments, forKey: .attachments)
		}

		try container.encodeIfPresent(channelData, forKey: .channelData)
		try container.encode(from, forKey: .from)
		try container.encodeIfPresent(text, forKey: .text)
		try container.encodeIfPresent(textFormat, forKey: .textFormat)
		try container.encode(type, forKey: .type)
	}
}

public extension Activity {
	init(attachments: [Attachment] = [], channelData: ChannelData? = nil, from: ChannelAccount, text: String? = nil, textFormat: TextFormat? = nil, type: ActivityType) {
		self.attachments = attachments
		self.channelData = channelData
		self.from = from
		self.text = text
		self.textFormat = textFormat
		self.type = type

		timestamp = nil
		attachmentLayout = nil
		id = ""
		inputHint = nil
		locale = nil
		replyToId = nil
		speak = nil
		suggestedActions = nil
	}

	static func message(from: ChannelAccount, text: String, channelData: ChannelData, attachments: [Attachment] = []) -> Activity {
		return Activity(attachments: attachments, channelData: channelData, from: from, text: text, type: .message)
	}

	static func typing(from: ChannelAccount, channelData: ChannelData) -> Activity {
		return Activity(channelData: channelData, from: from, type: .typing)
	}
}

public extension Activity where ChannelData == Empty {
	static func message(from: ChannelAccount, text: String, attachments: [Attachment] = []) -> Activity {
		return Activity(attachments: attachments, channelData: nil, from: from, text: text, type: .message)
	}

	static func typing(from: ChannelAccount) -> Activity {
		return Activity(channelData: nil, from: from, type: .typing)
	}
}
