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

class WebSocketActivityStreamTest: XCTestCase {
	private var sut: WebSocketActivityStream<Empty>!
	private let webSocketMock = WebSocketMock()

	override func setUp() {
		super.setUp()
		sut = WebSocketActivityStream { [webSocketMock] url in
			XCTAssertEqual(url, Constants.streamURL)
			return webSocketMock
		}
	}
}

extension WebSocketActivityStreamTest {
	func testActivityStream_subscribe_openWebSocket() {
		// given
		let activityList = sut.activityList(with: Constants.streamURL)

		// when
		_ = activityList.subscribe()

		// then
		XCTAssertEqual(webSocketMock.openCount, 1)
	}

	func testActivityStream_dispose_closeWebSocket() {
		// given
		let activityList = sut.activityList(with: Constants.streamURL)
		let disposable = activityList.subscribe()

		// when
		disposable.dispose()

		// then
		XCTAssertEqual(webSocketMock.closeCount, 1)
	}

	func testActivitiesMessage_didReceiveMessage_onNext() {
		// given
		let message = givenActivitiesMessage()
		var result: ActivityList<Empty>?

		// when
		_ = sut.activityList(with: Constants.streamURL).subscribe(onNext: { result = $0 })
		webSocketMock.didReceiveMessage(message)

		// then
		XCTAssertNotNil(result)
	}

	func testConnectionError_didFail_onError() {
		// given
		let error = givenConnectionError()
		var result: Error?

		// when
		_ = sut.activityList(with: Constants.streamURL).subscribe(onError: { result = $0 })
		webSocketMock.didFail(error)

		// then
		XCTAssertNotNil(result)
	}

	func testNotCompleted_didClose_onCompleted() {
		// given
		var completed = false

		// when
		_ = sut.activityList(with: Constants.streamURL).subscribe(onCompleted: { completed = true })
		webSocketMock.didClose(42)

		// then
		XCTAssertTrue(completed)
	}
}

private extension WebSocketActivityStreamTest {
	enum Constants {
		static let streamURL = URL(string: "https://directline.botframework.com/v3/directline/conversations/abc123/stream?t=RCurR_XV9ZA")!
	}

	func givenActivitiesMessage() -> Data {
		return """
		{
		  "activities": [
		    {
		      "type": "message",
		      "channelId": "directline",
		      "conversation": {
		        "id": "abc123"
		      },
		      "id": "abc123|0000",
		      "from": {
		        "id": "user1"
		      },
		      "text": "hello"
		    }
		  ],
		  "watermark": "0000a-42"
		}
		""".data(using: .utf8)!
	}

	func givenConnectionError() -> Error {
		return URLError(.networkConnectionLost)
	}
}
