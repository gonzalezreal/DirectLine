import Foundation

public enum Endpoint {
	case start(secret: String)
	case refresh(token: String)
	case reconnect(conversation: Conversation)
	case post(activity: Activity, conversation: Conversation)
	case activities(conversation: Conversation, watermark: String?)
}

internal extension Endpoint {
	func request(with baseURL: URL) -> URLRequest {
		let url = baseURL.appendingPathComponent(path)

		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.queryItems = parameters?.map(URLQueryItem.init)

		var request = URLRequest(url: components.url!)
		request.httpMethod = method.rawValue
		request.allHTTPHeaderFields = headers
		request.httpBody = body

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
		case .start, .refresh, .post:
			return .post
		case .reconnect, .activities:
			return .get
		}
	}

	var path: String {
		switch self {
		case .start:
			return "conversations"
		case .refresh:
			return "tokens/refresh"
		case let .reconnect(conversation):
			return "conversations/\(conversation.conversationId)"
		case let .post(_, conversation):
			return "conversations/\(conversation.conversationId)/activities"
		case let .activities(conversation, _):
			return "conversations/\(conversation.conversationId)/activities"
		}
	}

	var headers: [String : String] {
		switch self {
		case let .start(secret):
			return ["Authorization": "Bearer \(secret)"]
		case let .refresh(token):
			return ["Authorization": "Bearer \(token)"]
		case let .reconnect(conversation):
			return ["Authorization": "Bearer \(conversation.token)"]
		case let .post(_, conversation):
			return [
				"Authorization": "Bearer \(conversation.token)",
				"Content-Type": "application/json; charset=utf-8"
			]
		case let .activities(conversation, _):
			return ["Authorization": "Bearer \(conversation.token)"]
		}
	}

	var parameters: [String: String]? {
		switch self {
		case let .activities(_, watermark):
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
		case let .post(activity, _):
			let encoder = JSONEncoder()
			return try? encoder.encode(activity)
		default:
			return nil
		}
	}
}
