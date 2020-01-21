@testable import DirectLine
import XCTest

final class ActivityTypeTests: XCTestCase {
    func testDecodeMessage() throws {
        // given
        let json = """
        {
          "type": "message",
          "text": "Hello and **welcome**!",
          "textFormat": "markdown",
          "locale": "en-US",
          "speak": "Hello and welcome!",
          "inputHint": "acceptingInput",
          "attachments": [
            {
              "contentType": "video/mp4",
              "contentUrl": "http://example.com/video.mp4"
            }
          ],
          "attachmentLayout": "list",
          "suggestedActions": {
            "actions": [
              {
                "type": "imBack",
                "title": "Do something",
                "value": "do something"
              }
            ]
          },
          "value": "foo"
        }
        """.data(using: .utf8)!

        // when
        let result = try JSONDecoder().decode(ActivityType.self, from: json)

        // then
        XCTAssertEqual("Hello and **welcome**!", result.messageActivity?.text)
        XCTAssertEqual(.markdown, result.messageActivity?.textFormat)
        XCTAssertEqual("en-US", result.messageActivity?.locale)
        XCTAssertEqual("Hello and welcome!", result.messageActivity?.speak)
        XCTAssertEqual(.acceptingInput, result.messageActivity?.inputHint)
        XCTAssertEqual([.url(URLAttachment(contentType: "video/mp4", contentURL: URL(string: "http://example.com/video.mp4")!, name: nil, thumbnailURL: nil))], result.messageActivity?.attachments)
        XCTAssertEqual(.list, result.messageActivity?.attachmentLayout)
        XCTAssertEqual(SuggestedActions(to: [], actions: [.imBack(IMBackAction(title: "Do something", image: nil, value: "do something"))]), result.messageActivity?.suggestedActions)
        XCTAssertEqual(.string("foo"), result.messageActivity?.value)
    }

    func testEncodeMessage() throws {
        // given
        let activityType = ActivityType.message(MessageActivity(text: "Hello there", textFormat: .plain, value: .string("foo")))
        let expected = """
        {
          "text" : "Hello there",
          "textFormat" : "plain",
          "type" : "message",
          "value" : "foo"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(activityType)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeEndOfConversation() throws {
        // given
        let json = """
        {
          "type": "endOfConversation",
          "text": "Bye!",
          "code": "completedSuccessfully"
        }
        """.data(using: .utf8)!
        let expected = ActivityType.endOfConversation(EndOfConversationActivity(text: "Bye!", code: "completedSuccessfully"))

        // when
        let result = try JSONDecoder().decode(ActivityType.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeEndOfConversation() throws {
        // given
        let activityType = ActivityType.endOfConversation(EndOfConversationActivity(text: "Bye!", code: "completedSuccessfully"))
        let expected = """
        {
          "code" : "completedSuccessfully",
          "text" : "Bye!",
          "type" : "endOfConversation"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(activityType)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeTyping() throws {
        // given
        let json = """
        {
          "type": "typing"
        }
        """.data(using: .utf8)!
        let expected = ActivityType.typing

        // when
        let result = try JSONDecoder().decode(ActivityType.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeTyping() throws {
        // given
        let activityType = ActivityType.typing
        let expected = """
        {
          "type" : "typing"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(activityType)

        // then
        XCTAssertEqual(expected, result)
    }

    static var allTests = [
        ("testDecodeMessage", testDecodeMessage),
        ("testEncodeMessage", testEncodeMessage),
        ("testDecodeEndOfConversation", testDecodeEndOfConversation),
        ("testEncodeEndOfConversation", testEncodeEndOfConversation),
        ("testDecodeTyping", testDecodeTyping),
        ("testEncodeTyping", testEncodeTyping),
    ]
}

private extension ActivityType {
    var messageActivity: MessageActivity? {
        switch self {
        case let .message(result):
            return result
        default:
            return nil
        }
    }
}
