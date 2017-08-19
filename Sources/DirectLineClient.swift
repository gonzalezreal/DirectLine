import Foundation
import RxSwift

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
			.map(T.self, using: decoder)
	}
}
