//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

/// Defines a Direct Line conversation.
public struct Conversation: Equatable, Decodable {
	private enum CodingKeys: String, CodingKey {
		case conversationId, token
		case expiresIn = "expires_in"
		case streamURL = "streamUrl"
	}

	/// Uniquely identifies the conversation for which the specified token is valid.
	public let conversationId: String

	/// Number of seconds until the token expires.
	public let expiresIn: TimeInterval

	/// URL for the conversation's message stream.
	public let streamURL: URL?

	/// Token that is valid for the specified conversation.
	public let token: String
}
