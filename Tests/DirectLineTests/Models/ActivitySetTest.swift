import XCTest
import DirectLine

class ActivitySetTest: XCTestCase {
	func testDecodeActivitySet() {
		// given
		let json = """
		{
			"activities": [
				{
					"type": "message",
					"id": "GNqZzvYP9Zb2x4VoufTUzl|0000002",
					"timestamp": "2017-08-13T09:32:28.5262964Z",
					"channelId": "directline",
					"from": {
						"id": "user1"
					},
					"conversation": {
						"id": "GNqZzvYP9Zb2x4VoufTUzl"
					},
					"text": "hello"
				}
			],
			"watermark": "1"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// then
		XCTAssertNoThrow(try decoder.decode(ActivitySet.self, from: json))
	}

	func testDecodeActivitySetWithoutWatermark() {
		// given
		let json = """
		{
			"activities": [
				{
					"type": "message",
					"id": "GNqZzvYP9Zb2x4VoufTUzl|0000002",
					"timestamp": "2017-08-13T09:32:28.5262964Z",
					"channelId": "directline",
					"from": {
						"id": "user1"
					},
					"conversation": {
						"id": "GNqZzvYP9Zb2x4VoufTUzl"
					},
					"text": "hello"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// then
		XCTAssertNoThrow(try decoder.decode(ActivitySet.self, from: json))
	}
}
