//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

internal extension Request where Body == Empty, Response == Conversation {
	/// Returns a request that opens a new conversation with the bot.
	static func startConversation(withToken token: String) -> Request {
		return Request(token: token, method: .post, path: "conversations")
	}
}
