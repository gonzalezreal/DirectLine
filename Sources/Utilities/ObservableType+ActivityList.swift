import Foundation
import Starscream
import RxSwift

internal extension DispatchQueue {
	static let webSocketQueue = DispatchQueue(label: "com.DirectLine.WebSocket")
}

internal extension ObservableType where E == ActivityList {
	static func activityStream(url: URL) -> Observable<E> {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)

		return Observable.create { observer in
			let socket = WebSocket(url: url)
			socket.callbackQueue = .webSocketQueue

			socket.onDisconnect = { error in
				if let error = error {
					observer.onError(error)
				} else {
					observer.onCompleted()
				}
			}

			socket.onData = { data in
				observer.onNext(data)
			}

			socket.connect()

			return Disposables.create {
				if socket.isConnected {
					socket.disconnect()
				}
			}
		}
		.map(ActivityList.self, using: decoder)
	}
}
