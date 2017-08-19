import Foundation
import Starscream
import RxSwift

internal extension Observable where E == Data {
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
