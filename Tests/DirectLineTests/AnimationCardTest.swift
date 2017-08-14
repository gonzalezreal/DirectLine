import XCTest
import DirectLine

class AnimationCardTest: XCTestCase {
	func testAutoloopDefaultsToTrue() {
		// given
		let json = """
		{
			"media": [
				{
					"url": "http://i.giphy.com/Ki55RUbOV5njy.gif"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(AnimationCard.self, from: json)

		// then
		XCTAssertEqual(card?.autoloop, true)
	}

	func testAutostartDefaultsToTrue() {
		// given
		let json = """
		{
			"media": [
				{
					"url": "http://i.giphy.com/Ki55RUbOV5njy.gif"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(AnimationCard.self, from: json)

		// then
		XCTAssertEqual(card?.autostart, true)
	}

	func testShareableDefaultsToTrue() {
		// given
		let json = """
		{
			"media": [
				{
					"url": "http://i.giphy.com/Ki55RUbOV5njy.gif"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(AnimationCard.self, from: json)

		// then
		XCTAssertEqual(card?.shareable, true)
	}
}
