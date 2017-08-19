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
	private let streamObservable: (URL) -> Observable<Data>
	private let session: URLSession
	private let decoder: JSONDecoder

	convenience init(baseURL: URL = .directLineBaseURL) {
		self.init(baseURL: baseURL, streamObservable: Observable.from(streamURL:))
	}

	internal init(baseURL: URL, streamObservable: @escaping (URL) -> Observable<Data>) {
		self.baseURL = baseURL
		self.streamObservable = streamObservable
		self.session = URLSession(configuration: .default)
		self.decoder = JSONDecoder()
		self.decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
	}

	public func request<T>(_ type: T.Type, from endpoint: Endpoint) -> Observable<T> where T: Decodable {
		return session.rx.data(request: endpoint.request(with: baseURL))
			.mapError(using: decoder)
			.map(T.self, using: decoder)
	}

	public func activities(streamURL: URL) -> Observable<Activity> {
		return streamObservable(streamURL)
			.map(ActivitySet.self, using: decoder)
			.flatMap { return Observable.from($0.activities) }
	}
}
