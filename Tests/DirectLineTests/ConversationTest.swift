import XCTest
import DirectLine

class ConversationTest: XCTestCase {
	func testDecodeJSONConversation() {
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
		let decoder = JSONDecoder()

		// then
		XCTAssertNoThrow(try decoder.decode(Conversation.self, from: json))
	}
}
