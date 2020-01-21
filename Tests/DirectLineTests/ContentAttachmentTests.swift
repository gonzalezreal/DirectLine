@testable import DirectLine
import XCTest

final class ContentAttachmentTests: XCTestCase {
    override func setUp() {
        super.setUp()
        ContentAttachment.register(TestCard.self, contentType: TestCard.contentType)
    }

    override func tearDown() {
        ContentAttachment.unregister(contentType: TestCard.contentType)
        super.tearDown()
    }

    func testDecodeUnknownContentAttachment() throws {
        // given
        let json = """
        {
          "contentType": "message/partial",
          "content": {
            "foo": "bar",
            "baz": "qux",
          }
        }
        """.data(using: .utf8)!
        let expected = ContentAttachment(contentType: "message/partial", content: nil, name: nil, thumbnailURL: nil)

        // when
        let result = try JSONDecoder().decode(ContentAttachment.self, from: json)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEqualContentAttachment() {
        // given
        let attachment1 = ContentAttachment(contentType: TestCard.contentType, content: TestCard(foo: "bar"), name: "bar", thumbnailURL: URL(string: "http://example.com/thumb.png")!)
        let attachment2 = ContentAttachment(contentType: TestCard.contentType, content: TestCard(foo: "bar"), name: "bar", thumbnailURL: URL(string: "http://example.com/thumb.png")!)

        // when
        let result = (attachment1 == attachment2)

        // then
        XCTAssertTrue(result)
    }

    func testNotEqualContentAttachment() {
        // given
        let attachment1 = ContentAttachment(contentType: TestCard.contentType, content: TestCard(foo: "bar"), name: nil, thumbnailURL: nil)
        let attachment2 = ContentAttachment(contentType: TestCard.contentType, content: TestCard(foo: "baz"), name: nil, thumbnailURL: nil)

        // when
        let result = (attachment1 == attachment2)

        // then
        XCTAssertFalse(result)
    }

    static var allTests = [
        ("testDecodeUnknownContentAttachment", testDecodeUnknownContentAttachment),
        ("testEqualContentAttachment", testEqualContentAttachment),
        ("testNotEqualContentAttachment", testNotEqualContentAttachment),
    ]
}
