import XCTest
import DirectLine

class VideoCardTest: XCTestCase {
	func testVideoCardWithoutAutoloopJSON_decode_autoloopIsTrue() {
		// given
		let json = """
		{
			"buttons": [],
			"media": [
				{
					"url": "http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(VideoCard.self, from: json)

		// then
		XCTAssertEqual(card?.autoloop, true)
	}

	func testVideoCardWithoutAutostartJSON_decode_autostartIsTrue() {
		// given
		let json = """
		{
			"buttons": [],
			"media": [
				{
					"url": "http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(VideoCard.self, from: json)

		// then
		XCTAssertEqual(card?.autostart, true)
	}

	func testVideoCardWithoutShareableJSON_decode_shareableIsTrue() {
		// given
		let json = """
		{
			"buttons": [],
			"media": [
				{
					"url": "http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4"
				}
			]
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let card = try? decoder.decode(VideoCard.self, from: json)

		// then
		XCTAssertEqual(card?.isShareable, true)
	}
}
