import XCTest
@testable import DirectLine

final class DirectLineTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DirectLine().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
