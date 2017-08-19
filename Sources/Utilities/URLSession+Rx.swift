import Foundation
import RxSwift

internal extension Reactive where Base: URLSession {
	func data(request: URLRequest) -> Observable<Data> {
		return Observable.create { observer in
			let task = self.base.dataTask(with: request) { data, response, error in
				if let error = error {
					observer.onError(DirectLineError.other(error))
				} else {
					guard let httpResponse = response as? HTTPURLResponse else {
						fatalError("Unsupported protocol")
					}

					if 200 ..< 300 ~= httpResponse.statusCode {
						if let data = data {
							observer.onNext(data)
						}
						observer.onCompleted()
					} else {
						observer.onError(DirectLineError.badStatus(httpResponse.statusCode, data ?? Data()))
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
