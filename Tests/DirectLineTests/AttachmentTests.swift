@testable import DirectLine
import XCTest

final class AttachmentTests: XCTestCase {
    override func setUp() {
        super.setUp()
        ContentAttachment.register(TestCard.self, contentType: TestCard.contentType)
    }

    override func tearDown() {
        ContentAttachment.unregister(contentType: TestCard.contentType)
        super.tearDown()
    }

    func testDecodeURLAttachment() throws {
        // given
        let json = """
        {
          "contentType": "video/mp4",
          "contentUrl": "http://example.com/video.mp4"
        }
        """.data(using: .utf8)!
        let expected = Attachment.url(URLAttachment(contentType: "video/mp4", contentURL: URL(string: "http://example.com/video.mp4")!, name: nil, thumbnailURL: nil))

        // when
        let result = try JSONDecoder().decode(Attachment.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeURLAttachment() throws {
        // given
        let attachment = Attachment.url(URLAttachment(contentType: "video/mp4", contentURL: URL(string: "http://example.com/video.mp4")!, name: nil, thumbnailURL: nil))
        let expected = """
        {
          "contentType" : "video\\/mp4",
          "contentUrl" : "http:\\/\\/example.com\\/video.mp4"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(attachment)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeContentAttachment() throws {
        // given
        let json = """
        {
          "contentType": "application/vnd.gonzalezreal.card.test",
          "content": {
            "foo": "bar"
          }
        }
        """.data(using: .utf8)!
        let expected = Attachment.content(ContentAttachment(contentType: TestCard.contentType, content: TestCard(foo: "bar"), name: nil, thumbnailURL: nil))

        // when
        let result = try JSONDecoder().decode(Attachment.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeContentAttachment() throws {
        // given
        let attachment = Attachment.content(ContentAttachment(contentType: TestCard.contentType, content: TestCard(foo: "bar"), name: nil, thumbnailURL: nil))
        let expected = """
        {
          "content" : {
            "foo" : "bar"
          },
          "contentType" : "application\\/vnd.gonzalezreal.card.test"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        // when
        let result = try encoder.encode(attachment)

        // then
        XCTAssertEqual(expected, result)
    }

    static var allTests = [
        ("testDecodeURLAttachment", testDecodeURLAttachment),
        ("testEncodeURLAttachment", testEncodeURLAttachment),
        ("testDecodeContentAttachment", testDecodeContentAttachment),
        ("testEncodeContentAttachment", testEncodeContentAttachment),
    ]
}
