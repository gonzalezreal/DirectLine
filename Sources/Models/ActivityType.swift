//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

/// Type of activity.
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
