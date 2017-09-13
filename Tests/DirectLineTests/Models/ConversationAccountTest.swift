import XCTest
import DirectLine

class ConversationAccountTest: XCTestCase {
	func testConversationAccountWithoutIsGroupJSON_decode_isGroupDefaultsToFalse() {
		// given
		let json = """
		{
			"id": "GNqZzvYP9Zb2x4VoufTUzl"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let conversationAccount = try? decoder.decode(ConversationAccount.self, from: json)

		// then
		XCTAssertEqual(conversationAccount?.isGroup, false)
	}
}
