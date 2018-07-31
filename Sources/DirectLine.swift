//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import RxSwift

public final class DirectLine<ChannelData: Codable> {
	public private(set) lazy var activities = conversation
		.flatMapLatest { [activityStream] in activityStream.activityList(with: $0.streamURL!) }
		.flatMap { Observable.from($0.activities) }
		.share(replay: 1, scope: .whileConnected)
	private lazy var conversation = client.startConversation(withToken: token)
		.share(replay: 1, scope: .whileConnected)

	private let token: String
	private let client: Client
	private let activityStream: AnyActivityStream<ChannelData>

	internal init<A: ActivityStream>(token: String, client: Client, activityStream: A) where A.ChannelData == ChannelData {
		self.token = token
		self.client = client
		self.activityStream = AnyActivityStream(activityStream)
	}

	public convenience init(token: String, baseURL: URL = .directLine, session: URLSession = URLSession(configuration: .default)) {
		self.init(token: token, client: ClientImpl(baseURL: baseURL, session: session), activityStream: WebSocketActivityStream())
	}

	public func send(activity: Activity<ChannelData>) -> Observable<Resource> {
		return conversation
			.flatMapLatest { [client] in client.sendActivity(activity, to: $0.conversationId, withToken: $0.token) }
	}
}

public extension DirectLine where ChannelData == Empty {
	convenience init(token: String, baseURL: URL = .directLine, session: URLSession = URLSession(configuration: .default)) {
		self.init(token: token, client: ClientImpl(baseURL: baseURL, session: session), activityStream: WebSocketActivityStream())
	}
}
