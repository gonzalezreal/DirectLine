//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import DirectLine
import XCTest

class ActivityTest: XCTestCase {
	private struct TestChannelData: Codable {
		let foo: String
	}

	func testMessageActivity_encode_returnsExpectedJSON() throws {
		// given
		let activity = Activity.message(from: ChannelAccount(id: "p3c4d0r", name: "Lucas"),
		                                text: "Lorem fistrum")
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.sortedKeys]
		let expected = "{\"from\":{\"id\":\"p3c4d0r\",\"name\":\"Lucas\"},\"text\":\"Lorem fistrum\",\"type\":\"message\"}".data(using: .utf8)!

		// when
		let result = try encoder.encode(activity)

		// then
		XCTAssertEqual(result, expected)
	}

	func testMessageActivityWithChannelData_encode_returnsExpectedJSON() throws {
		// given
		let activity = Activity.message(from: ChannelAccount(id: "p3c4d0r", name: "Lucas"),
		                                text: "Lorem fistrum",
		                                channelData: TestChannelData(foo: "bar"))
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.sortedKeys]
		let expected = "{\"channelData\":{\"foo\":\"bar\"},\"from\":{\"id\":\"p3c4d0r\",\"name\":\"Lucas\"},\"text\":\"Lorem fistrum\",\"type\":\"message\"}".data(using: .utf8)!

		// when
		let result = try encoder.encode(activity)

		// then
		XCTAssertEqual(result, expected)
	}

	func testMessageActivityWithAttachment_encode_returnsExpectedJSON() throws {
		// given
		let attachment = Attachment(contentType: "image/jpg", url: URL(string: "http://example.com/fistro.jpg")!)
		let activity = Activity.message(from: ChannelAccount(id: "p3c4d0r", name: "Lucas"),
		                                text: "Lorem fistrum",
		                                attachments: [attachment])
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.sortedKeys]
		let expected = "{\"attachments\":[{\"contentType\":\"image\\/jpg\",\"contentUrl\":\"http:\\/\\/example.com\\/fistro.jpg\"}],\"from\":{\"id\":\"p3c4d0r\",\"name\":\"Lucas\"},\"text\":\"Lorem fistrum\",\"type\":\"message\"}".data(using: .utf8)!

		// when
		let result = try encoder.encode(activity)

		// then
		XCTAssertEqual(result, expected)
	}

	func testMinimalActivityJSON_decode_returnsActivity() {
		// given
		let json = """
		{
		  "from": {
		    "id": "p3c4d0r",
		    "name": "Lucas"
		  },
		  "id": "JaybClPg3UxFly6NFX9wVj|0000003",
		  "text": "Lorem fistrum",
		  "timestamp": "2018-07-25T13:17:51.8514686Z",
		  "type": "message"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(.iso8601WithFractionalSeconds)

		// when / then
		XCTAssertNoThrow(try decoder.decode(Activity<Empty>.self, from: json))
	}

	func testActivityJSON_decode_returnsActivity() {
		// given
		let json = """
		{
		  "attachments": [
		    {
		      "contentType": "application/test",
		      "content": {}
		    }
		  ],
		  "attachmentLayout": "carousel",
		  "channelData": {
		    "foo": "bar"
		  },
		  "from": {
		    "id": "p3c4d0r",
		    "name": "Lucas"
		  },
		  "id": "JaybClPg3UxFly6NFX9wVj|0000003",
		  "inputHint": "ignoringInput",
		  "locale": "en-US",
		  "replyToId": "JaybClPg3UxFly6NFX9wVj|0000002",
		  "speak": "Lorem fistrum",
		  "suggestedActions": {
		    "actions": [
		      {
		        "type": "postBack",
		        "title": "Gromenauer grimor",
		        "value": "Gromenauer"
		      }
		    ]
		  },
		  "text": "Lorem fistrum",
		  "textFormat": "plain",
		  "timestamp": "2018-07-25T13:17:51.8514686Z",
		  "type": "message"
		}
		""".data(using: .utf8)!

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(.iso8601WithFractionalSeconds)

		// when / then
		XCTAssertNoThrow(try decoder.decode(Activity<TestChannelData>.self, from: json))
	}
}
