import XCTest
@testable import DirectLine

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
		let expectedMedia = Media(contentType: .imageJPG, contentURL: URL(string: "http://example.com/fistro.jpg")!)
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .media(expectedMedia))
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
			"content": {
				"type": "AdaptiveCard"
			}
		}
		""".data(using: .utf8)!
		let expectedCard = AdaptiveCard()
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .adaptiveCard(expectedCard))
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
		let expectedCard = AnimationCard(autoloop: true,
		                                 autostart: true,
		                                 buttons: [],
		                                 image: nil,
		                                 media: [MediaURL(url: URL(string: "http://i.giphy.com/Ki55RUbOV5njy.gif")!, profile: nil)],
		                                 isShareable: true,
		                                 subtitle: "Animation Card",
		                                 text: nil,
		                                 title: "Microsoft Bot Framework")
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .animationCard(expectedCard))
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
		let expectedCard = AudioCard(aspect: nil,
		                             autoloop: true,
		                             autostart: true,
		                             buttons: [CardAction(action: .open(URL(string: "https://en.wikipedia.org/wiki/The_Empire_Strikes_Back")!),
		                                                  title: "Read More",
		                                                  image: nil)],
		                             image: ThumbnailURL(url: URL(string: "https://upload.wikimedia.org/wikipedia/en/3/3c/SW_-_Empire_Strikes_Back.jpg")!, description: nil),
		                             media: [MediaURL(url: URL(string: "http://i.giphy.com/Ki55RUbOV5njy.gif")!, profile: nil)],
		                             isShareable: true,
		                             subtitle: "Star Wars: Episode V - The Empire Strikes Back",
		                             text: nil,
		                             title: "I am your father")
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .audioCard(expectedCard))
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
					"url": "https://upload.wikimedia.org/220px-Big_buck_bunny_poster_big.jpg"
				},
				"media": [
					{
						"url": "http://download.blender.org/BigBuckBunny_320x180.mp4"
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
		let expectedCard = VideoCard(autoloop: true,
		                             autostart: true,
		                             buttons: [CardAction(action: .open(URL(string: "https://peach.blender.org/")!),
		                                                  title: "Learn More",
		                                                  image: nil)],
		                             image: ThumbnailURL(url: URL(string: "https://upload.wikimedia.org/220px-Big_buck_bunny_poster_big.jpg")!, description: nil),
		                             media: [MediaURL(url: URL(string: "http://download.blender.org/BigBuckBunny_320x180.mp4")!, profile: nil)],
		                             isShareable: true,
		                             subtitle: "by the Blender Institute",
		                             text: nil,
		                             title: "Big Buck Bunny")
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .videoCard(expectedCard))
	}

	func testHeroCardJSON_decode_returnsAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.card.hero",
			"content": {
				"title": "BotFramework Hero Card",
				"subtitle": "Your bots — wherever your users are talking",
				"text": "Build and connect intelligent bots...",
				"images": [
					{
						"url": "https://sec.ch9.ms/botframework_960.jpg"
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
		let expectedCard = HeroCard(buttons: [CardAction(action: .open(URL(string: "https://docs.microsoft.com/bot-framework")!),
		                                                 title: "Get Started",
		                                                 image: nil)],
		                            images: [CardImage(url: URL(string: "https://sec.ch9.ms/botframework_960.jpg")!,
		                                               tap: nil,
		                                               description: nil)],
		                            subtitle: "Your bots — wherever your users are talking",
		                            tap: nil,
		                            text: "Build and connect intelligent bots...",
		                            title: "BotFramework Hero Card")
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .heroCard(expectedCard))
	}

	func testThumbnailCardJSON_decode_returnsAttachment() {
		// given
		let json = """
		{
			"contentType": "application/vnd.microsoft.card.thumbnail",
			"content": {
				"title": "BotFramework Thumbnail Card",
				"subtitle": "Your bots — wherever your users are talking",
				"text": "Build and connect intelligent bots...",
				"images": [
					{
						"url": "https://sec.ch9.ms/botframework_960.jpg"
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
		let expectedCard = ThumbnailCard(buttons: [CardAction(action: .open(URL(string: "https://docs.microsoft.com/bot-framework")!),
		                                                      title: "Get Started",
		                                                      image: nil)],
		                                 images: [CardImage(url: URL(string: "https://sec.ch9.ms/botframework_960.jpg")!,
		                                                    tap: nil,
		                                                    description: nil)],
		                                 subtitle: "Your bots — wherever your users are talking",
		                                 tap: nil,
		                                 text: "Build and connect intelligent bots...",
		                                 title: "BotFramework Thumbnail Card")
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .thumbnailCard(expectedCard))
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
							"url": "https://github.com/traffic-manager.png",
						}
					}
				],
				"tax": "$ 7.50",
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
		let expectedCard = ReceiptCard(buttons: [CardAction(action: .open(URL(string: "https://azure.microsoft.com/en-us/pricing/")!),
		                                                    title: "More information",
		                                                    image: nil)],
		                               facts: [Fact(key: "Order Number", value: "1234"),
		                                       Fact(key: "Payment Method", value: "VISA 5555-****")],
		                               items: [ReceiptItem(image: CardImage(url: URL(string: "https://github.com/traffic-manager.png")!,
		                                                                    tap: nil,
		                                                                    description: nil),
		                                                   price: "$ 38.45",
		                                                   quantity: "368",
		                                                   subtitle: nil,
		                                                   tap: nil,
		                                                   text: nil,
		                                                   title: "Data Transfer")],
		                               tap: nil,
		                               tax: "$ 7.50",
		                               title: "John Doe",
		                               total: nil,
		                               vat: nil)
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .receiptCard(expectedCard))
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
		let expectedCard = SignInCard(buttons: [CardAction(action: .signin(URL(string: "https://login.microsoftonline.com/")!),
		                                                   title: nil,
		                                                   image: nil)],
		                              text: "BotFramework Sign-in Card")
		let decoder = JSONDecoder()

		// when
		let attachment = try? decoder.decode(Attachment.self, from: json)

		// then
		XCTAssertEqual(attachment!.content, .signInCard(expectedCard))
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
		XCTAssertEqual(attachment!.content, .unknown)
	}
}
