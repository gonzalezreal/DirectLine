import Foundation
import Starscream
import RxSwift

public extension ObservableType where E == Activity {
	static func activityStream(url: URL) -> Observable<E> {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)

		return Observable.from(streamURL: url)
			.map(ActivitySet.self, using: decoder)
			.flatMap { return Observable.from($0.activities) }
	}
}

internal extension ObservableType where E == Data {
	static func from(streamURL: URL) -> Observable<E> {
		return Observable.create { observer in
			let socket = WebSocket(url: streamURL)
			socket.callbackQueue = DispatchQueue(label: "com.DirectLine.WebSocket")

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
	}
}
