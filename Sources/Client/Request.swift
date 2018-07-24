//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

internal enum RequestMethod: String {
	case get = "GET"
	case post = "POST"
}

/// A DirectLine request.
internal struct Request<Body: Encodable, Response: Decodable> {
	let token: String
	let method: RequestMethod
	let path: String
	let parameters: [String: String]
	let body: Body?

	init(token: String, method: RequestMethod, path: String, parameters: [String: String] = [:], body: Body? = nil) {
		self.token = token
		self.method = method
		self.path = path
		self.parameters = parameters
		self.body = body
	}
}

/// Returns a request that opens a new conversation with the bot.
internal func startConversation(withToken token: String) -> Request<Empty, Conversation> {
	return Request(token: token, method: .post, path: "conversations")
}

/// Returns a request that refreshes a conversation token.
internal func refreshToken(_ token: String) -> Request<Empty, Conversation> {
	return Request(token: token, method: .post, path: "tokens/refresh")
}

/// Returns a request that reconnects to an existing conversation.
internal func reconnect(to conversationId: String, watermark: String?, withToken token: String) -> Request<Empty, Conversation> {
	return Request(token: token,
	               method: .get,
	               path: "conversations/\(conversationId)",
	               parameters: watermark.map { ["watermark": $0] } ?? [:])
}

/// Returns a request that sends an activity to the bot.
internal func sendActivity<ChannelData: Codable>(_ activity: Activity<ChannelData>, to conversationId: String, withToken token: String) -> Request<Activity<ChannelData>, Resource> {
	return Request(token: token,
	               method: .post,
	               path: "conversations/\(conversationId)/activities",
	               body: activity)
}
