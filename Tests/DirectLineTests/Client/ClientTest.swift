//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

@testable import DirectLine
import RxBlocking
import RxSwift
import XCTest

class ClientTest: XCTestCase {
	private var sut: Client!
	private let sessionMock = URLSessionMock()

	override func setUp() {
		sut = Client(session: sessionMock, baseURL: .directLine)
	}
}

extension ClientTest {
	func testAnyResponse_responseForAnyRequest_resumesDataTask() {
		// given
		givenAnyResponse()

		// when
		_ = sut.response(for: Constants.anyRequest).subscribe()

		// then
		XCTAssertEqual(sessionMock.dataTask.resumeCount, 1)
	}

	func testConversationResponse_responseForConversationRequest_returnsConversation() throws {
		// given
		givenConversationResponse()

		// when
		let result = try sut.response(for: Constants.conversationRequest)
			.toBlocking()
			.single()

		// then
		XCTAssertEqual(result, Constants.conversation)
	}

	func testInvalidTokenResponse_responseForAnyRequest_failsWithInvalidToken() {
		// given
		givenInvalidTokenResponse()

		// when
		let response = sut.response(for: Constants.anyRequest)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting invalidToken") { error in
			XCTAssertEqual(error as! DirectLineError, .invalidToken)
		}
	}

	func testBotNotAvailableResponse_responseForAnyRequest_failsWithBotNotAvailable() {
		// given
		givenBotNotAvailableResponse()

		// when
		let response = sut.response(for: Constants.anyRequest)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting botNotAvailable") { error in
			XCTAssertEqual(error as! DirectLineError, .botNotAvailable)
		}
	}

	func testInternalServerErrorResponse_responseForAnyRequest_failsWithBadStatus() {
		// given
		givenInternalServerErrorResponse()

		// when
		let response = sut.response(for: Constants.anyRequest)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting badStatus") { error in
			XCTAssertEqual(error as! DirectLineError, .badStatus(500))
		}
	}

	func testTimedOutError_responseForAnyRequest_failsWithTimedOut() {
		// given
		givenTimedOutError()

		// when
		let response = sut.response(for: Constants.anyRequest)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting timedOut") { error in
			XCTAssertEqual(error as! DirectLineError, .timedOut)
		}
	}

	func testCannotConnectToHostError_responseForAnyRequest_failsWithCannotConnect() {
		// given
		givenCannotConnectToHostError()

		// when
		let response = sut.response(for: Constants.anyRequest)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting cannotConnect") { error in
			XCTAssertEqual(error as! DirectLineError, .cannotConnect)
		}
	}

	func testNetworkConnectionLostError_responseForAnyRequest_failsWithConnectionLost() {
		// given
		givenNetworkConnectionLostError()

		// when
		let response = sut.response(for: Constants.anyRequest)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting connectionLost") { error in
			XCTAssertEqual(error as! DirectLineError, .connectionLost)
		}
	}

	func testNotConnectedToInternetError_responseForAnyRequest_failsWithNotConnected() {
		// given
		givenNotConnectedToInternetError()

		// when
		let response = sut.response(for: Constants.anyRequest)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting notConnected") { error in
			XCTAssertEqual(error as! DirectLineError, .notConnected)
		}
	}

	func testAnyError_responseForAnyRequest_failsWithOther() {
		// given
		givenAnyError()

		// when
		let response = sut.response(for: Constants.anyRequest)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting other") { error in
			XCTAssertEqual(error as! DirectLineError, .other(Constants.anyError))
		}
	}
}

private extension ClientTest {
	enum Constants {
		static let secret = "f15tr0"
		static let anyRequest = Request<Empty, Empty>(token: secret, method: .post, path: "any")
		static let conversationRequest = Request<Empty, Conversation>(token: secret, method: .post, path: "someConversation")
		static let conversation = Conversation(conversationId: "abc123",
		                                       expiresIn: 1_800,
		                                       streamURL: URL(string: "https://directline.botframework.com/v3/directline/conversations/abc123/stream?t=RCurR_XV9ZA")!,
		                                       token: "RCurR_XV9ZA")
		static let anyError = NSError(domain: "test", code: 42, userInfo: nil)
	}

	func givenAnyResponse() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(data: Data(), statusCode: 200, with: request)
	}

	func givenConversationResponse() {
		let conversationData = """
		{
			"conversationId": "\(Constants.conversation.conversationId)",
			"token": "\(Constants.conversation.token)",
			"expires_in": \(Constants.conversation.expiresIn),
			"streamUrl": "\(Constants.conversation.streamURL!.absoluteString)"
		}
		""".data(using: .utf8)!
		let request = URLRequest(baseURL: .directLine, request: Constants.conversationRequest)
		sessionMock.stub(data: conversationData, statusCode: 201, with: request)
	}

	func givenInvalidTokenResponse() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(data: Data(), statusCode: 403, with: request)
	}

	func givenBotNotAvailableResponse() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(data: Data(), statusCode: 502, with: request)
	}

	func givenInternalServerErrorResponse() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(data: Data(), statusCode: 500, with: request)
	}

	func givenTimedOutError() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(error: URLError(.timedOut), with: request)
	}

	func givenCannotConnectToHostError() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(error: URLError(.cannotConnectToHost), with: request)
	}

	func givenNetworkConnectionLostError() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(error: URLError(.networkConnectionLost), with: request)
	}

	func givenNotConnectedToInternetError() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(error: URLError(.notConnectedToInternet), with: request)
	}

	func givenAnyError() {
		let request = URLRequest(baseURL: .directLine, request: Constants.anyRequest)
		sessionMock.stub(error: Constants.anyError, with: request)
	}
}
