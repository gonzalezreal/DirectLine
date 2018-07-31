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

class ClientImplTest: XCTestCase {
	private var sut: ClientImpl!
	private let sessionMock = URLSessionMock()

	override func setUp() {
		super.setUp()
		sut = ClientImpl(session: sessionMock, baseURL: .directLine)
	}
}

extension ClientImplTest {
	func testConversationResponse_startConversation_resumesDataTask() {
		// given
		givenConversationResponse()

		// when
		_ = sut.startConversation(withToken: Constants.secret).subscribe()

		// then
		XCTAssertEqual(sessionMock.dataTask.resumeCount, 1)
	}

	func testConversationResponse_startConversation_returnsConversation() throws {
		// given
		givenConversationResponse()

		// when
		let result = try sut.startConversation(withToken: Constants.secret)
			.toBlocking()
			.single()

		// then
		XCTAssertEqual(result, Constants.conversation)
	}

	func testInvalidTokenResponse_startConversation_failsWithInvalidToken() {
		// given
		givenInvalidTokenResponse()

		// when
		let response = sut.startConversation(withToken: Constants.secret)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting invalidToken") { error in
			XCTAssertEqual(error as! DirectLineError, .invalidToken)
		}
	}

	func testTimedOutError_startConversation_failsWithTimedOut() {
		// given
		givenTimedOutError()

		// when
		let response = sut.startConversation(withToken: Constants.secret)

		// then
		XCTAssertThrowsError(try response.toBlocking().single(), "expecting timedOut") { error in
			XCTAssertEqual(error as! DirectLineError, .timedOut)
		}
	}
}

private extension ClientImplTest {
	enum Constants {
		static let secret = "f15tr0"
		static let request = Request.startConversation(withToken: secret)
		static let conversation = Conversation(conversationId: "abc123",
		                                       expiresIn: 1_800,
		                                       streamURL: URL(string: "https://directline.botframework.com/v3/directline/conversations/abc123/stream?t=RCurR_XV9ZA")!,
		                                       token: "RCurR_XV9ZA")
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
		let request = URLRequest(baseURL: .directLine, request: Constants.request)
		sessionMock.stub(data: conversationData, statusCode: 201, with: request)
	}

	func givenInvalidTokenResponse() {
		let request = URLRequest(baseURL: .directLine, request: Constants.request)
		sessionMock.stub(data: Data(), statusCode: 403, with: request)
	}

	func givenTimedOutError() {
		let request = URLRequest(baseURL: .directLine, request: Constants.request)
		sessionMock.stub(error: URLError(.timedOut), with: request)
	}
}
