import XCTest
@testable import DirectLine

class EndpointTest: XCTestCase {
	func testStartEndpoint() {
		// given
		let endpoint: Endpoint = .startConversation(token: "secret")

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
		let endpoint: Endpoint = .reconnect(conversationId: "1234", token: "3xpo")

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
			"Authorization": "Bearer 3xpo",
			"Content-Type": "application/json; charset=utf-8"
		]
		let endpoint: Endpoint = .post(activity: activity, conversationId: "1234", token: "3xpo")

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
		let endpoint: Endpoint = .activities(conversationId: "1234", token: "3xpo", watermark: nil)

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
		let endpoint: Endpoint = .activities(conversationId: "1234", token: "3xpo", watermark: "3")
		var components = URLComponents(url: URL.directLineBaseURL.appendingPathComponent("conversations/1234/activities"), resolvingAgainstBaseURL: false)!
		components.queryItems = [URLQueryItem(name: "watermark", value: "3")]

		// when
		let request = endpoint.request(with: .directLineBaseURL)

		// then
		XCTAssertEqual(request.url, components.url)
	}
}
