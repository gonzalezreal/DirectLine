//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import os.log
import RxSwift

internal protocol Client {
	/// Open a new conversation with the bot.
	func startConversation(withToken token: String) -> Observable<Conversation>

	/// Refresh an existing conversation token.
	func refreshToken(_ token: String) -> Observable<Conversation>

	/// Reconnect to an existing conversation.
	func reconnect(to conversationId: String, watermark: String?, withToken token: String) -> Observable<Conversation>

	/// Send an activity to the bot.
	func sendActivity<ChannelData: Codable>(_ activity: Activity<ChannelData>, to conversationId: String, withToken token: String) -> Observable<Resource>
}

internal final class ClientImpl {
	private let baseURL: URL
	private let session: URLSession
	private let decoder = JSONDecoder()

	init(baseURL: URL, session: URLSession) {
		self.baseURL = baseURL
		self.session = session

		decoder.dateDecodingStrategy = .formatted(.iso8601WithFractionalSeconds)
	}
}

extension ClientImpl: Client {
	func startConversation(withToken token: String) -> Observable<Conversation> {
		return response(Conversation.self, for: .startConversation(withToken: token))
	}

	func refreshToken(_ token: String) -> Observable<Conversation> {
		return response(Conversation.self, for: .refreshToken(token))
	}

	func reconnect(to conversationId: String, watermark: String?, withToken token: String) -> Observable<Conversation> {
		return response(Conversation.self, for: .reconnect(to: conversationId, watermark: watermark, withToken: token))
	}

	func sendActivity<ChannelData: Codable>(_ activity: Activity<ChannelData>, to conversationId: String, withToken token: String) -> Observable<Resource> {
		return response(Resource.self, for: .sendActivity(activity, to: conversationId, withToken: token))
	}
}

private extension ClientImpl {
	func response<Response, Body>(_ type: Response.Type, for request: Request<Body>) -> Observable<Response> where Body: Encodable, Response: Decodable {
		let urlRequest = URLRequest(baseURL: baseURL, request: request)
		return data(with: urlRequest).map(to: Response.self, using: decoder)
	}

	func data(with request: URLRequest) -> Observable<Data> {
		return Observable.create { [session] observer in
			let task = session.dataTask(with: request) { data, response, error in
				if let error = error {
					os_log("%{public}@ '%{public}@': %{public}@", log: .http, type: .error, request.httpMethod!, request.url!.absoluteString, error.localizedDescription)
					observer.onError(DirectLineError(error: error))
				} else {
					guard let httpResponse = response as? HTTPURLResponse else {
						fatalError("Unsupported protocol")
					}

					os_log("%d '%{public}@'", log: .http, type: .debug, httpResponse.statusCode, request.url!.absoluteString)

					if 200 ..< 300 ~= httpResponse.statusCode {
						if let data = data {
							observer.onNext(data)
						}
						observer.onCompleted()
					} else {
						observer.onError(DirectLineError(statusCode: httpResponse.statusCode))
					}
				}
			}

			os_log("%{public}@ '%{public}@'", log: .http, type: .debug, request.httpMethod!, request.url!.absoluteString)

			task.resume()

			return Disposables.create {
				task.cancel()
			}
		}
	}
}

private extension OSLog {
	static let http = OSLog(subsystem: "com.gonzalezreal.DirectLine.HTTP", category: "DirectLine.HTTP")
}
