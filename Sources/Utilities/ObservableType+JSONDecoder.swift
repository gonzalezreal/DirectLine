import Foundation
import RxSwift

internal extension ObservableType where E == Data {
	func mapError(using decoder: JSONDecoder) -> Observable<E> {
		return catchError { error in
			guard let directLineError = error as? DirectLineClientError else {
				throw error
			}

			guard case let .badStatus(status, data) = directLineError else {
				throw error
			}

			guard let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) else {
				throw error
			}

			throw DirectLineClientError.api(status, errorResponse)
		}
	}

	func map<T>(_ type: T.Type, using decoder: JSONDecoder) -> Observable<T> where T: Decodable {
		return map { try decoder.decode(T.self, from: $0) }
	}
}
