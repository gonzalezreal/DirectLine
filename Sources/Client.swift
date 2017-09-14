import Foundation
import RxSwift

internal final class Client {
	private let baseURL: URL
	private let session: URLSession
	private let decoder: JSONDecoder

	init(baseURL: URL) {
		self.baseURL = baseURL
		self.session = URLSession(configuration: .default)
		self.decoder = JSONDecoder()
		self.decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
	}

	func request<T>(_ type: T.Type, from endpoint: Endpoint) -> Observable<T> where T: Decodable {
		return session.rx.data(request: endpoint.request(with: baseURL))
			.map(to: T.self, using: decoder)
	}
}
