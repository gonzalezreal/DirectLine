//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import RxSwift

internal final class Client {
	private let session: URLSession
	private let baseURL: URL
	private let decoder = JSONDecoder()

	init(session: URLSession, baseURL: URL) {
		self.session = session
		self.baseURL = baseURL

		decoder.dateDecodingStrategy = .formatted(.iso8601WithFractionalSeconds)
	}
}

internal extension Client {
	func response<Body, Response>(for request: Request<Body, Response>) -> Observable<Response> where Body: Encodable, Response: Decodable {
		let urlRequest = URLRequest(baseURL: baseURL, request: request)
		return data(with: urlRequest).map(to: Response.self, using: decoder)
	}
}

private extension Client {
	func data(with request: URLRequest) -> Observable<Data> {
		return Observable.create { [session] observer in
			let task = session.dataTask(with: request) { data, response, error in
				if let error = error {
					observer.onError(DirectLineError(error: error))
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
						observer.onError(DirectLineError(statusCode: httpResponse.statusCode))
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
