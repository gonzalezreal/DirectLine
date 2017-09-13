import XCTest
import DirectLine

class AttachmentTest: XCTestCase {
	func testMediaJSON_decode_returnsAttachment() {
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

	func testMediaAttachment_encode_returnsJSON() {
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

	func testAdaptiveCardJSON_decode_returnsAttachment() {
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

	func testAnimationCardJSON_decode_returnsAttachment() {
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

	func testAudioCardJSON_decode_returnsAttachment() {
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

	func testVideoCardJSON_decode_returnsAttachment() {
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

	func testHeroCardJSON_decode_returnsAttachment() {
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

	func testThumbnailCardJSON_decode_returnsAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.card.thumbnail",
			"content": {
				"title": "BotFramework Thumbnail Card",
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
		XCTAssertTrue(attachment?.isThumbnailCard ?? false)
	}

	func testReceiptCardJSON_decode_returnsAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.com.card.receipt",
			"content": {
				"title": "John Doe",
				"facts": [
					{
						"key": "Order Number",
						"value": "1234"
					},
					{
						"key": "Payment Method",
						"value": "VISA 5555-****"
					}
				],
				"items": [
					{
						"title": "Data Transfer",
						"price": "$ 38.45",
						"quantity": "368",
						"image": {
							"url": "https://github.com/amido/azure-vector-icons/raw/master/renders/traffic-manager.png",
						}
					},
					{
						"title": "App Service",
						"price": "$ 45.00",
						"quantity": "720",
						"image": {
							"url": "https://github.com/amido/azure-vector-icons/raw/master/renders/cloud-service.png",
						}
					},
				],
				"tax": "$ 7.50",
				"tax": "$ 90.95",
				"buttons": [
					{
						"title": "More information",
						"type": "openUrl",
						"value": "https://azure.microsoft.com/en-us/pricing/"
					}
				]
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isReceiptCard ?? false)
	}

	func testSignInCardJSON_decode_returnsAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.com.card.signin",
			"content": {
				"text": "BotFramework Sign-in Card",
				"buttons": [
					{
						"type": "signin",
						"value": "https://login.microsoftonline.com/"
					}
				]
			}
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertTrue(attachment?.isSignInCard ?? false)
	}

	func testUnknownJSON_decode_returnsAttachment() {
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

	var isThumbnailCard: Bool {
		switch content {
		case .thumbnailCard:
			return true
		default:
			return false
		}
	}

	var isReceiptCard: Bool {
		switch content {
		case .receiptCard:
			return true
		default:
			return false
		}
	}

	var isSignInCard: Bool {
		switch content {
		case .signInCard:
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
