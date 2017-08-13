import XCTest
import DirectLine

class ErrorResponseTest: XCTestCase {
	func testDecodeJSONErrorResponse() {
		// given
		let json = """
		{
			"error": {
				"code": "BadArgument",
				"message": "Invalid token or secret"
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// then
		XCTAssertNoThrow(try decoder.decode(ErrorResponse.self, from: json))
	}
}
