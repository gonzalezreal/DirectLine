import XCTest
import OHHTTPStubs
import RxSwift
import RxBlocking

@testable import DirectLine

class DirectLineClientTest: XCTestCase {
	var sut: DirectLineClient!
    
    override func setUp() {
        super.setUp()
        sut = DirectLineClient()
    }

	override func tearDown() {
		OHHTTPStubs.removeAllStubs()
		super.tearDown()
	}

	func testRequest() {
		// given
		let json = """
		{
			"conversationId": "the_conversation_id",
			"token": "some_token",
			"expires_in": 1800,
			"streamUrl": "wss://example.com/stream",
			"referenceGrammarId": "some_grammar_id",
		}
		""".data(using: .utf8)!
		let expected = Conversation(conversationId: "the_conversation_id",
		                            token: "some_token",
		                            expiresIn: 1800,
		                            streamURL: URL(string: "wss://example.com/stream"))
		stubResponse(withData: json, statusCode: 201)

		// when
		let result = try! sut.request(Conversation.self, from: .start(secret: "secret"))
			.toBlocking()
			.single()

		// then
		XCTAssertEqual(result, expected)
	}

	func testRequestAPIError() {
		// given
		let json = """
		{
		  "error": {
			"code": "TokenExpired",
			"message": "Token has expired"
		  }
		}
		""".data(using: .utf8)!
		let expectedError = DirectLineError.api(
			403,
			ErrorResponse(error: ErrorResponse.Error(code: "TokenExpired", message: "Token has expired"))
		)
		stubResponse(withData: json, statusCode: 403)

		// when
		let observable = sut.request(Conversation.self, from: .start(secret: "secret"))

		// then
		XCTAssertThrowsError(try observable.toBlocking().single(), "error expected") { error in
			if let error = error as? DirectLineError {
				XCTAssertEqual(error, expectedError)
			} else {
				XCTFail()
			}
		}
	}

	func testRequestOtherError() {
		// given
		let otherError = NSError(domain: "test", code: 42, userInfo: nil)
		stubResponse(withError: otherError)

		// when
		let observable = sut.request(Conversation.self, from: .start(secret: "secret"))

		// then
		XCTAssertThrowsError(try observable.toBlocking().single(), "error expected") { error in
			if let error = error as? DirectLineError {
				XCTAssertEqual(error, DirectLineError.other(otherError))
			} else {
				XCTFail()
			}
		}
	}
}

private extension DirectLineClientTest {
	func stubResponse(withData data: Data, statusCode: Int32) {
		stub(condition: isHost("directline.botframework.com")) { request in
			return OHHTTPStubsResponse(data: data, statusCode: statusCode, headers: nil)
		}
	}

	func stubResponse(withError error: Error) {
		stub(condition: isHost("directline.botframework.com")) { request in
			return OHHTTPStubsResponse(error: error)
		}
	}
}
