import XCTest
import DirectLine

class VideoCardTest: XCTestCase {
	func testAutoloopDefaultsToTrue() {
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

	func testAutostartDefaultsToTrue() {
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

	func testShareableDefaultsToTrue() {
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
		XCTAssertEqual(card?.shareable, true)
	}
}
