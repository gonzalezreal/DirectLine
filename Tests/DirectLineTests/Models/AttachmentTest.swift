//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import DirectLine
import XCTest

class AttachmentTest: XCTestCase {
	private struct TestCard: Attachable {
		static let contentType = "application/gonzalezreal.card.test"
		let foo: String
	}

	override func setUp() {
		super.setUp()
		Attachment.register(TestCard.self)
	}
}

extension AttachmentTest {
	func testMediaAttachment_decode_returnsAttachment() throws {
		// given
		let json = """
		{
			"contentType": "image/jpg",
			"contentUrl": "http://example.com/fistro.jpg",
			"name": "Fistro",
			"thumbnailUrl": "http://example.com/fistro_thumb.jpg",
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment.contentType, "image/jpg")
		XCTAssertEqual(attachment.content, .media(URL(string: "http://example.com/fistro.jpg")!))
		XCTAssertEqual(attachment.name, "Fistro")
		XCTAssertEqual(attachment.thumbnailURL, URL(string: "http://example.com/fistro_thumb.jpg")!)
	}

	func testMediaAttachment_encode_returnsExpectedJSON() throws {
		// given
		let attachment = Attachment(contentType: "image/jpg",
		                            url: URL(string: "http://example.com/fistro.jpg")!,
		                            name: "Fistro",
		                            thumbnailURL: URL(string: "http://example.com/fistro_thumb.jpg")!)
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.sortedKeys]
		let expected = "{\"contentType\":\"image\\/jpg\",\"contentUrl\":\"http:\\/\\/example.com\\/fistro.jpg\",\"name\":\"Fistro\",\"thumbnailUrl\":\"http:\\/\\/example.com\\/fistro_thumb.jpg\"}".data(using: .utf8)!

		// when
		let result = try encoder.encode(attachment)

		// then
		XCTAssertEqual(result, expected)
	}

	func testCardAttachment_decode_returnsCardContent() throws {
		// given
		let json = """
		{
			"contentType": "\(TestCard.contentType)",
			"content": {
				"foo": "bar"
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment.contentType, TestCard.contentType)
		XCTAssertEqual(attachment.content, .card(TestCard(foo: "bar")))
		XCTAssertNil(attachment.name)
		XCTAssertNil(attachment.thumbnailURL)
	}

	func testUnknownAttachment_decode_returnsUnknownContent() throws {
		// given
		let json = """
		{
			"contentType": "application/unknown",
			"content": {
				"lorem": "fistrum"
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment.contentType, "application/unknown")
		XCTAssertEqual(attachment.content, .unknown)
		XCTAssertNil(attachment.name)
		XCTAssertNil(attachment.thumbnailURL)
	}
}
