//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

@testable import DirectLine
import XCTest

class RequestTest: XCTestCase {
	func testStartConversation_urlRequest_isValidRequest() {
		// given
		let request = startConversation(withToken: "f15tr0")

		// when
		let urlRequest = URLRequest(baseURL: .directLine, request: request)

		// then
		XCTAssertEqual(urlRequest.url, URL.directLine.appendingPathComponent("conversations"))
		XCTAssertEqual(urlRequest.httpMethod, "POST")
		XCTAssertEqual(urlRequest.allHTTPHeaderFields!, ["Authorization": "Bearer f15tr0"])
		XCTAssertNil(urlRequest.httpBody)
	}

	func testRefreshToken_urlRequest_isValidRequest() {
		// given
		let request = refreshToken("f15tr0")

		// when
		let urlRequest = URLRequest(baseURL: .directLine, request: request)

		// then
		XCTAssertEqual(urlRequest.url, URL.directLine.appendingPathComponent("tokens/refresh"))
		XCTAssertEqual(urlRequest.httpMethod, "POST")
		XCTAssertEqual(urlRequest.allHTTPHeaderFields!, ["Authorization": "Bearer f15tr0"])
		XCTAssertNil(urlRequest.httpBody)
	}

	func testReconnect_urlRequest_isValidRequest() {
		// given
		let request = reconnect(to: "1234", watermark: nil, withToken: "f15tr0")

		// when
		let urlRequest = URLRequest(baseURL: .directLine, request: request)

		// then
		XCTAssertEqual(urlRequest.url, URL.directLine.appendingPathComponent("conversations/1234"))
		XCTAssertEqual(urlRequest.httpMethod, "GET")
		XCTAssertEqual(urlRequest.allHTTPHeaderFields!, ["Authorization": "Bearer f15tr0"])
		XCTAssertNil(urlRequest.httpBody)
	}

	func testReconnectWithWatermark_urlRequest_isValidRequest() {
		// given
		let request = reconnect(to: "1234", watermark: "3", withToken: "f15tr0")
		var components = URLComponents(url: URL.directLine.appendingPathComponent("conversations/1234"),
		                               resolvingAgainstBaseURL: false)!
		components.queryItems = [URLQueryItem(name: "watermark", value: "3")]

		// when
		let urlRequest = URLRequest(baseURL: .directLine, request: request)

		// then
		XCTAssertEqual(urlRequest.url, components.url)
	}

	func testSendActivity_urlRequest_isValidRequest() throws {
		// given
		let activity = Activity.message(from: ChannelAccount(id: "p3c4d0r"), text: "Lorem fistrum")
		let expectedBody = try JSONEncoder().encode(activity)
		let expectedHeaders = [
			"Authorization": "Bearer f15tr0",
			"Content-Type": "application/json; charset=utf-8"
		]
		let request = sendActivity(activity, to: "1234", withToken: "f15tr0")

		// when
		let urlRequest = URLRequest(baseURL: .directLine, request: request)

		// then
		XCTAssertEqual(urlRequest.url, URL.directLine.appendingPathComponent("conversations/1234/activities"))
		XCTAssertEqual(urlRequest.httpMethod, "POST")
		XCTAssertEqual(urlRequest.allHTTPHeaderFields!, expectedHeaders)
		XCTAssertEqual(urlRequest.httpBody, expectedBody)
	}
}
