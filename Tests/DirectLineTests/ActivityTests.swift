@testable import DirectLine
import XCTest

final class ActivityTests: XCTestCase {
    func testDecodeActivity() throws {
        // given
        let json = """
        {
          "type": "message",
          "id": "65sTOV6IpR543ZZ0CAF1cw-a|0000000",
          "timestamp": "2020-01-18T11:24:56.6812353Z",
          "channelId": "directline",
          "from": {
            "id": "echo-bot",
            "name": "echo-bot"
          },
          "conversation": {
            "id": "65sTOV6IpR543ZZ0CAF1cw-a"
          },
          "text": "Hello and welcome!",
          "inputHint": "acceptingInput",
          "replyToId": "CduuBUeZbNl",
          "channelData": {
            "foo": "bar"
          }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds

        // when
        let result = try decoder.decode(Activity<TestData>.self, from: json)

        // then
        XCTAssertEqual("65sTOV6IpR543ZZ0CAF1cw-a|0000000", result.id)
        XCTAssertEqual(ISO8601DateFormatter.withFractionalSeconds.date(from: "2020-01-18T11:24:56.6812353Z"), result.timestamp)
        XCTAssertEqual(ChannelAccount(id: "echo-bot", name: "echo-bot"), result.from)
        XCTAssertEqual(ConversationAccount(id: "65sTOV6IpR543ZZ0CAF1cw-a"), result.conversation)
        XCTAssertEqual("CduuBUeZbNl", result.replyToId)
        XCTAssertEqual(TestData(foo: "bar"), result.channelData)
    }

    func testEncodeActivity() throws {
        // given
        let activity = Activity(
            type: .message(MessageActivity(text: "Eres un fistro!")),
            from: ChannelAccount(id: "condemor"),
            channelData: TestData(foo: "bar")
        )
        let expected = """
        {
          "channelData" : {
            "foo" : "bar"
          },
          "from" : {
            "id" : "condemor"
          },
          "text" : "Eres un fistro!",
          "type" : "message"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(activity)

        // then
        XCTAssertEqual(expected, result)
    }

    static var allTests = [
        ("testDecodeActivity", testDecodeActivity),
        ("testEncodeActivity", testEncodeActivity),
    ]
}
