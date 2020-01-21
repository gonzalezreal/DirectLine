@testable import DirectLine
import XCTest

final class CardActionTests: XCTestCase {
    func testDecodeMessageBack() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "messageBack",
          "value": [
            "foo"
          ]
        }
        """.data(using: .utf8)!
        let expected = CardAction.messageBack(MessageBackAction(title: "Foo", image: nil, text: nil, displayText: nil, value: .array([.string("foo")])))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeMessageBack() throws {
        // given
        let action = CardAction.messageBack(MessageBackAction(title: "Foo", image: nil, text: nil, displayText: nil, value: .array([.string("foo")])))
        let expected = """
        {
          "title" : "Foo",
          "type" : "messageBack",
          "value" : [
            "foo"
          ]
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeIMBack() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "imBack",
          "value": "foo"
        }
        """.data(using: .utf8)!
        let expected = CardAction.imBack(IMBackAction(title: "Foo", image: nil, value: "foo"))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeIMBack() throws {
        // given
        let action = CardAction.imBack(IMBackAction(title: "Foo", image: nil, value: "foo"))
        let expected = """
        {
          "title" : "Foo",
          "type" : "imBack",
          "value" : "foo"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodePostBack() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "postBack",
          "value": ["foo"]
        }
        """.data(using: .utf8)!
        let expected = CardAction.postBack(PostBackAction(title: "Foo", image: nil, value: .array([.string("foo")])))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodePostBack() throws {
        // given
        let action = CardAction.postBack(PostBackAction(title: "Foo", image: nil, value: .array([.string("foo")])))
        let expected = """
        {
          "title" : "Foo",
          "type" : "postBack",
          "value" : [
            "foo"
          ]
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeOpenURL() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "openUrl",
          "value": "https://example.com/test"
        }
        """.data(using: .utf8)!
        let expected = CardAction.openURL(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeOpenURL() throws {
        // given
        let action = CardAction.openURL(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))
        let expected = """
        {
          "title" : "Foo",
          "type" : "openUrl",
          "value" : "https:\\/\\/example.com\\/test"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeDownloadFile() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "downloadFile",
          "value": "https://example.com/test"
        }
        """.data(using: .utf8)!
        let expected = CardAction.downloadFile(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeDownloadFile() throws {
        // given
        let action = CardAction.downloadFile(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))
        let expected = """
        {
          "title" : "Foo",
          "type" : "downloadFile",
          "value" : "https:\\/\\/example.com\\/test"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeShowImage() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "showImage",
          "value": "https://example.com/test"
        }
        """.data(using: .utf8)!
        let expected = CardAction.showImage(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeShowImage() throws {
        // given
        let action = CardAction.showImage(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))
        let expected = """
        {
          "title" : "Foo",
          "type" : "showImage",
          "value" : "https:\\/\\/example.com\\/test"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeSignIn() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "signin",
          "value": "https://example.com/test"
        }
        """.data(using: .utf8)!
        let expected = CardAction.signIn(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeSignIn() throws {
        // given
        let action = CardAction.signIn(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))
        let expected = """
        {
          "title" : "Foo",
          "type" : "signin",
          "value" : "https:\\/\\/example.com\\/test"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodePlayAudio() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "playAudio",
          "value": "https://example.com/test"
        }
        """.data(using: .utf8)!
        let expected = CardAction.playAudio(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodePlayAudio() throws {
        // given
        let action = CardAction.playAudio(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))
        let expected = """
        {
          "title" : "Foo",
          "type" : "playAudio",
          "value" : "https:\\/\\/example.com\\/test"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodePlayVideo() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "playVideo",
          "value": "https://example.com/test"
        }
        """.data(using: .utf8)!
        let expected = CardAction.playVideo(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodePlayVideo() throws {
        // given
        let action = CardAction.playVideo(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))
        let expected = """
        {
          "title" : "Foo",
          "type" : "playVideo",
          "value" : "https:\\/\\/example.com\\/test"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeCall() throws {
        // given
        let json = """
        {
          "title": "Foo",
          "type": "call",
          "value": "https://example.com/test"
        }
        """.data(using: .utf8)!
        let expected = CardAction.call(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeCall() throws {
        // given
        let action = CardAction.call(URLAction(title: "Foo", image: nil, url: URL(string: "https://example.com/test")!))
        let expected = """
        {
          "title" : "Foo",
          "type" : "call",
          "value" : "https:\\/\\/example.com\\/test"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(action)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeUnknown() throws {
        // given
        let json = """
        {
          "title": "Whatever",
          "type": "superunknown",
          "value": "doesn't matter"
        }
        """.data(using: .utf8)!
        let expected = CardAction.unknown

        // when
        let result = try JSONDecoder().decode(CardAction.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    static var allTests = [
        ("testDecodeMessageBack", testDecodeMessageBack),
        ("testEncodeMessageBack", testEncodeMessageBack),
        ("testDecodeIMBack", testDecodeIMBack),
        ("testEncodeIMBack", testEncodeIMBack),
        ("testDecodePostBack", testDecodePostBack),
        ("testEncodePostBack", testEncodePostBack),
        ("testDecodeOpenURL", testDecodeOpenURL),
        ("testEncodeOpenURL", testEncodeOpenURL),
        ("testDecodeDownloadFile", testDecodeDownloadFile),
        ("testEncodeDownloadFile", testEncodeDownloadFile),
        ("testDecodeShowImage", testDecodeShowImage),
        ("testEncodeShowImage", testEncodeShowImage),
        ("testDecodeSignIn", testDecodeSignIn),
        ("testEncodeSignIn", testEncodeSignIn),
        ("testDecodePlayAudio", testDecodePlayAudio),
        ("testEncodePlayAudio", testEncodePlayAudio),
        ("testDecodePlayVideo", testDecodePlayVideo),
        ("testEncodePlayVideo", testEncodePlayVideo),
        ("testDecodeCall", testDecodeCall),
        ("testEncodeCall", testEncodeCall),
        ("testDecodeUnknown", testDecodeUnknown),
    ]
}
