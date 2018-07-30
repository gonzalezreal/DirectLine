//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import RxSwift

internal final class WebSocketActivityStream<ChannelData: Codable>: ActivityStream {
	private let makeWebSocket: (URL) -> WebSocket
	private let decoder: JSONDecoder

	init(makeWebSocket: @escaping (URL) -> WebSocket = WebSocketImpl.init) {
		self.makeWebSocket = makeWebSocket

		decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(.iso8601WithFractionalSeconds)
	}

	func activityList(with url: URL) -> Observable<ActivityList<ChannelData>> {
		return Observable.create { [makeWebSocket] observer in
			let socket = makeWebSocket(url)

			socket.didReceiveMessage = { observer.onNext($0) }
			socket.didFail = { observer.onError($0) }
			socket.didClose = { _ in observer.onCompleted() }

			socket.open()

			return Disposables.create {
				socket.close()
			}
		}
		.map(to: ActivityList<ChannelData>.self, using: decoder)
	}
}
