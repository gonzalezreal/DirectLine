import XCTest
import DirectLine

class AttachmentTest: XCTestCase {
	func testDecodeJSONMediaAttachment() {
		// given
		let json = """
		{
			"contentType": "image/jpg",
			"contentUrl": "http://example.com/fistro.jpg",
			"name": "fistro.jpg"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isMedia ?? false)
	}
}

private extension Attachment {
	var isMedia: Bool {
		switch content {
		case .media:
			return true
		default:
			return false
		}
	}
}
