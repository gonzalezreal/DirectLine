import XCTest
import DirectLine

class AudioCardTest: XCTestCase {
	func testAudioCardWithoutAutoloopJSON_decode_autoloopIsTrue() {
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

	func testAudioCardWithoutAutostartJSON_decode_autostartIsTrue() {
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

	func testAudioCardWithoutShareable_decode_shareableIsTrue() {
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
		XCTAssertEqual(card?.isShareable, true)
	}
}
