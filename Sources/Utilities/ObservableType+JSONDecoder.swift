import Foundation
import RxSwift

internal extension ObservableType where E == Data {
	func map<T>(_ type: T.Type, using decoder: JSONDecoder) -> Observable<T> where T: Decodable {
		return map { try decoder.decode(T.self, from: $0) }
	}
}
