import XCTest
import DirectLine

class AttachmentTest: XCTestCase {
	func testDecodeMediaAttachment() {
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

	func testEncodeMediaAttachment() {
		// given
		let attachment = Attachment(
			content: .media(Media(contentType: .imageJPG, contentURL: URL(string: "http://example.com/fistro.jpg")!)),
			name: "fistro.jpg"
		)
		let expected = """
		{
		  "contentType" : "image\\/jpg",
		  "contentUrl" : "http:\\/\\/example.com\\/fistro.jpg",
		  "name" : "fistro.jpg"
		}
		""".data(using: .utf8)!
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted

		// when
		let result = (try? encoder.encode(attachment)) ?? Data()

		// then
		XCTAssertEqual(expected, result)
	}

	func testDecodeAdaptiveCardAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.card.adaptive",
			"content": {}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isAdaptiveCard ?? false)
	}

	func testDecodeAnimationCardAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.card.animation",
			"content": {
				"title": "Microsoft Bot Framework",
				"subtitle": "Animation Card",
				"buttons": [],
				"media": [
					{
						"url": "http://i.giphy.com/Ki55RUbOV5njy.gif"
					}
				]
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isAnimationCard ?? false)
	}

	func testDecodeAudioCardAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.card.audio",
			"content": {
				"title": "I am your father",
				"subtitle": "Star Wars: Episode V - The Empire Strikes Back",
				"image": {
					"url": "https://upload.wikimedia.org/wikipedia/en/3/3c/SW_-_Empire_Strikes_Back.jpg"
				},
				"media": [
					{
						"url": "http://i.giphy.com/Ki55RUbOV5njy.gif"
					}
				],
				"buttons": [
					{
						"title": "Read More",
						"type": "openUrl",
						"value": "https://en.wikipedia.org/wiki/The_Empire_Strikes_Back"
					}
				]
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isAudioCard ?? false)
	}

	func testDecodeVideoCardAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.card.video",
			"content": {
				"title": "Big Buck Bunny",
				"subtitle": "by the Blender Institute",
				"image": {
					"url": "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Big_buck_bunny_poster_big.jpg/220px-Big_buck_bunny_poster_big.jpg"
				},
				"media": [
					{
						"url": "http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4"
					}
				],
				"buttons": [
					{
						"title": "Learn More",
						"type": "openUrl",
						"value": "https://peach.blender.org/"
					}
				]
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isVideoCard ?? false)
	}

	func testDecodeHeroCardAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.card.hero",
			"content": {
				"title": "BotFramework Hero Card",
				"subtitle": "Your bots — wherever your users are talking",
				"text": "Build and connect intelligent bots to interact with your users naturally wherever they are, from text/sms to Skype, Slack, Office 365 mail and other popular services.",
				"images": [
					{
						"url": "https://sec.ch9.ms/ch9/7ff5/e07cfef0-aa3b-40bb-9baa-7c9ef8ff7ff5/buildreactionbotframework_960.jpg"
					}
				],
				"buttons": [
					{
						"title": "Get Started",
						"type": "openUrl",
						"value": "https://docs.microsoft.com/bot-framework"
					}
				]
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isHeroCard ?? false)
	}

	func testDecodeUnknownAttachment() {
		// given
		let json = """
		{
			"contentType": "application/unknown",
			"content": {
				"foo": "bar"
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isUnknown ?? false)
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

	var isAdaptiveCard: Bool {
		switch content {
		case .adaptiveCard:
			return true
		default:
			return false
		}
	}

	var isAnimationCard: Bool {
		switch content {
		case .animationCard:
			return true
		default:
			return false
		}
	}

	var isAudioCard: Bool {
		switch content {
		case .audioCard:
			return true
		default:
			return false
		}
	}

	var isVideoCard: Bool {
		switch content {
		case .videoCard:
			return true
		default:
			return false
		}
	}

	var isHeroCard: Bool {
		switch content {
		case .heroCard:
			return true
		default:
			return false
		}
	}

	var isUnknown: Bool {
		switch content {
		case .unknown:
			return true
		default:
			return false
		}
	}
}
