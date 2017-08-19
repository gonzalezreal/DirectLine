import XCTest
@testable import DirectLine

class EndpointTest: XCTestCase {
	private let conversation = Conversation(conversationId: "1234", token: "3xpo", expiresIn: 1800, streamURL: nil)

	func testStartEndpoint() {
		// given
		let endpoint: Endpoint = .start(secret: "secret")

		// when
		let request = endpoint.request(with: .directLineBaseURL)

		// then
		XCTAssertEqual(request.url, URL.directLineBaseURL.appendingPathComponent("conversations"))
		XCTAssertEqual(request.httpMethod, "POST")
		XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer secret"])
		XCTAssertNil(request.httpBody)
	}

	func testRefreshEndpoint() {
		// given
		let endpoint: Endpoint = .refresh(token: "token")

		// when
		let request = endpoint.request(with: .directLineBaseURL)

		// then
		XCTAssertEqual(request.url, URL.directLineBaseURL.appendingPathComponent("tokens/refresh"))
		XCTAssertEqual(request.httpMethod, "POST")
		XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer token"])
		XCTAssertNil(request.httpBody)
	}

	func testReconnectEndpoint() {
		// given
		let endpoint: Endpoint = .reconnect(conversation: conversation)

		// when
		let request = endpoint.request(with: .directLineBaseURL)

		// then
		XCTAssertEqual(request.url, URL.directLineBaseURL.appendingPathComponent("conversations/1234"))
		XCTAssertEqual(request.httpMethod, "GET")
		XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer 3xpo"])
		XCTAssertNil(request.httpBody)
	}

	func testPostEndpoint() {
		// given
		let activity = Activity(from: ChannelAccount(id: "guille"), text: "Hello")
		let encodedActivity = try! JSONEncoder().encode(activity)

		let headers = [
			"Authorization": "Bearer \(conversation.token)",
			"Content-Type": "application/json; charset=utf-8"
		]
		let endpoint: Endpoint = .post(activity: activity, conversation: conversation)

		// when
		let request = endpoint.request(with: .directLineBaseURL)

		// then
		XCTAssertEqual(request.url, URL.directLineBaseURL.appendingPathComponent("conversations/1234/activities"))
		XCTAssertEqual(request.httpMethod, "POST")
		XCTAssertEqual(request.allHTTPHeaderFields!, headers)
		XCTAssertEqual(request.httpBody, encodedActivity)
	}

	func testActivitiesEndpoint() {
		// given
		let endpoint: Endpoint = .activities(conversation: conversation, watermark: nil)

		// when
		let request = endpoint.request(with: .directLineBaseURL)

		// then
		XCTAssertEqual(request.url, URL.directLineBaseURL.appendingPathComponent("conversations/1234/activities"))
		XCTAssertEqual(request.httpMethod, "GET")
		XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer 3xpo"])
		XCTAssertNil(request.httpBody)
	}

	func testActivitiesWithWatermarkEndpoint() {
		// given
		let endpoint: Endpoint = .activities(conversation: conversation, watermark: "3")
		var components = URLComponents(url: URL.directLineBaseURL.appendingPathComponent("conversations/1234/activities"), resolvingAgainstBaseURL: false)!
		components.queryItems = [URLQueryItem(name: "watermark", value: "3")]

		// when
		let request = endpoint.request(with: .directLineBaseURL)

		// then
		XCTAssertEqual(request.url, components.url)
	}
}
