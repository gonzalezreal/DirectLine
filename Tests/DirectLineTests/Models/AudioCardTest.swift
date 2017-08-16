import XCTest
import DirectLine

class AudioCardTest: XCTestCase {
	func testAutoloopDefaultsToTrue() {
		// given
		let json = """
		{
			"buttons": [],
			"media": [
				{
					"url": "http://www.wavlist.com/movies/004/father.wav"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(AudioCard.self, from: json)

		// then
		XCTAssertEqual(card?.autoloop, true)
	}

	func testAutostartDefaultsToTrue() {
		// given
		let json = """
		{
			"buttons": [],
			"media": [
				{
					"url": "http://www.wavlist.com/movies/004/father.wav"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(AudioCard.self, from: json)

		// then
		XCTAssertEqual(card?.autostart, true)
	}

	func testShareableDefaultsToTrue() {
		// given
		let json = """
		{
			"buttons": [],
			"media": [
				{
					"url": "http://www.wavlist.com/movies/004/father.wav"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(AudioCard.self, from: json)

		// then
		XCTAssertEqual(card?.shareable, true)
	}
}
