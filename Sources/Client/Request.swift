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
internal struct Request<Body: Encodable> {
	let token: String
	let method: RequestMethod
	let path: String
	let parameters: [String: String]
	let body: Body?

	static func sendActivity<ChannelData: Codable>(_ activity: Activity<ChannelData>, to conversationId: String, withToken token: String) -> Request<Activity<ChannelData>> {
		return Request<Activity<ChannelData>>(token: token,
		                                      method: .post,
		                                      path: "conversations/\(conversationId)/activities",
		                                      body: activity)
	}
}

internal extension Request where Body == Empty {
	static func startConversation(withToken token: String) -> Request {
		return Request(token: token, method: .post, path: "conversations")
	}

	static func refreshToken(_ token: String) -> Request {
		return Request(token: token, method: .post, path: "tokens/refresh")
	}

	static func reconnect(to conversationId: String, watermark: String?, withToken token: String) -> Request {
		return Request(token: token,
		               method: .get,
		               path: "conversations/\(conversationId)",
		               parameters: watermark.map { ["watermark": $0] } ?? [:])
	}
}

private extension Request {
	init(token: String, method: RequestMethod, path: String, parameters: [String: String] = [:], body: Body) {
		self.token = token
		self.method = method
		self.path = path
		self.parameters = parameters
		self.body = body
	}
}

private extension Request where Body == Empty {
	init(token: String, method: RequestMethod, path: String, parameters: [String: String] = [:]) {
		self.token = token
		self.method = method
		self.path = path
		self.parameters = parameters
		body = nil
	}
}
