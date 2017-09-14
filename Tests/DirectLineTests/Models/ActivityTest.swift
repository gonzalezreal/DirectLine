import XCTest
import DirectLine

class ActivityTest: XCTestCase {
	func testActivityWithTextMessage_encode_returnsActivityJSON() {
		// given
		let activity = Activity(
			from: ChannelAccount(id: "user"),
			text: "Hello there"
		)
		let expected = """
		{
		  "attachments" : [

		  ],
		  "from" : {
		    "id" : "user"
		  },
		  "type" : "message",
		  "text" : "Hello there"
		}
		""".data(using: .utf8)!
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted

		// when
		let result = (try? encoder.encode(activity)) ?? Data()

		// then
		XCTAssertEqual(expected, result)
	}
}
