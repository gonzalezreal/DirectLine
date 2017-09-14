import XCTest
import DirectLine

class AnimationCardTest: XCTestCase {
	func testAnimationCardWithoutAutoloopJSON_decode_autoloopIsTrue() {
		// given
		let json = """
		{
			"buttons": [],
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

	func testAnimationCardWithoutAutostartJSON_decode_autostartIsTrue() {
		// given
		let json = """
		{
			"buttons": [],
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

	func testAnimationCardWithoutShareableJSON_decode_shareableIsTrue() {
		// given
		let json = """
		{
			"buttons": [],
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
		XCTAssertEqual(card?.isShareable, true)
	}
}
