import Foundation
import RxSwift

public enum DirectLineError: Error {
	case api(Int, ErrorResponse)
	case badStatus(Int, Data)
	case other(Error)
}

extension URL {
	public static let directLineBaseURL = URL(string: "https://directline.botframework.com/v3/directline")!
}

public final class DirectLineClient {
	private let baseURL: URL
	private let session: URLSession
	private let decoder: JSONDecoder

	public init(baseURL: URL = .directLineBaseURL) {
		self.baseURL = baseURL
		self.session = URLSession(configuration: .default)
		self.decoder = JSONDecoder()
		self.decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
	}

	public func request<T>(_ type: T.Type, from endpoint: Endpoint) -> Observable<T> where T: Decodable {
		return session.rx.data(request: endpoint.request(with: baseURL))
			.mapError(using: decoder)
			.map(T.self, using: decoder)
	}
}

private extension ObservableType where E == Data {
	func mapError(using decoder: JSONDecoder) -> Observable<E> {
		return catchError { error in
			guard let directLineError = error as? DirectLineError else {
				throw error
			}

			guard case let .badStatus(status, data) = directLineError else {
				throw error
			}

			guard let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) else {
				throw error
			}

			throw DirectLineError.api(status, errorResponse)
		}
	}

	func map<T>(_ type: T.Type, using decoder: JSONDecoder) -> Observable<T> where T: Decodable {
		return map { try decoder.decode(T.self, from: $0) }
	}
}

private extension Reactive where Base: URLSession {
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
