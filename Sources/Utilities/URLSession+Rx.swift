import Foundation
import RxSwift

public enum DirectLineURLError: Error {
	case nonHTTPResponse
	case badStatus(Int, Data)
}

internal extension Reactive where Base: URLSession {
	func data(request: URLRequest) -> Observable<Data> {
		return Observable.create { observer in
			let task = self.base.dataTask(with: request) { data, response, error in
				if let error = error {
					observer.onError(error)
				} else {
					guard let httpResponse = response as? HTTPURLResponse else {
						observer.onError(DirectLineURLError.nonHTTPResponse)
						return
					}

					if 200 ..< 300 ~= httpResponse.statusCode {
						if let data = data {
							observer.onNext(data)
						}
						observer.onCompleted()
					} else {
						observer.onError(DirectLineURLError.badStatus(httpResponse.statusCode, data ?? Data()))
					}
				}
			}

			task.resume()

			return Disposables.create {
				task.cancel()
			}
		}
	}
}
