import Foundation

internal enum Endpoint {
	case startConversation(token: String)
	case refresh(token: String)
	case reconnect(conversationId: String, token: String, watermark: String?)
	case post(activity: Activity, conversationId: String, token: String)
	case activities(conversationId: String, token: String, watermark: String?)
}

internal extension Endpoint {
	private static let timeout: TimeInterval = 20

	func request(with baseURL: URL) -> URLRequest {
		let url = baseURL.appendingPathComponent(path)

		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.queryItems = parameters?.map(URLQueryItem.init)

		var request = URLRequest(url: components.url!)
		request.httpMethod = method.rawValue
		request.allHTTPHeaderFields = headers
		request.httpBody = body
		request.timeoutInterval = Endpoint.timeout

		return request
	}
}

private enum Method: String {
	case get = "GET"
	case post = "POST"
}

private extension Endpoint {
	var method: Method {
		switch self {
		case .startConversation, .refresh, .post:
			return .post
		case .reconnect, .activities:
			return .get
		}
	}

	var path: String {
		switch self {
		case .startConversation:
			return "conversations"
		case .refresh:
			return "tokens/refresh"
		case let .reconnect(conversationId, _, _):
			return "conversations/\(conversationId)"
		case let .post(_, conversationId, _):
			return "conversations/\(conversationId)/activities"
		case let .activities(conversationId, _, _):
			return "conversations/\(conversationId)/activities"
		}
	}

	var headers: [String : String] {
		switch self {
		case let .startConversation(token):
			return ["Authorization": "Bearer \(token)"]
		case let .refresh(token):
			return ["Authorization": "Bearer \(token)"]
		case let .reconnect(_, token, _):
			return ["Authorization": "Bearer \(token)"]
		case let .post(_, _, token):
			return [
				"Authorization": "Bearer \(token)",
				"Content-Type": "application/json; charset=utf-8"
			]
		case let .activities(_, token, _):
			return ["Authorization": "Bearer \(token)"]
		}
	}

	var parameters: [String: String]? {
		switch self {
		case .reconnect(_, _, let watermark), .activities(_, _, let watermark):
			if let watermark = watermark {
				return ["watermark": watermark]
			} else {
				fallthrough
			}
		default:
			return nil
		}
	}

	var body: Data? {
		switch self {
		case let .post(activity, _, _):
			let encoder = JSONEncoder()
			return try? encoder.encode(activity)
		default:
			return nil
		}
	}
}
