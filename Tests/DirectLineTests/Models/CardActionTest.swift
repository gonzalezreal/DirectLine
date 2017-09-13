import XCTest
import DirectLine

class CardActionTest: XCTestCase {
	func testCardActionWithTitleJSON_decode_returnsCardActionWithTitle() {
		// given
		let json = """
		{
			"type": "openUrl",
			"value": "http://example.com",
			"title": "Example"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.title, "Example")
	}

	func testCardActionWithImageJSON_decode_returnsCardActionWithImage() {
		// given
		let json = """
		{
			"type": "openUrl",
			"value": "http://example.com",
			"image": "http://example.com/image.jpg"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.image, URL(string: "http://example.com/image.jpg"))
	}

	func testCardActionWithOpenURLJSON_decode_returnsOpenURLCardAction() {
		// given
		let json = """
		{
			"type": "openUrl",
			"value": "http://example.com"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.openURL, URL(string: "http://example.com"))
	}

	func testCardActionWithImBackJSON_decode_returnsImBackCardAction() {
		// given
		let json = """
		{
			"type": "imBack",
			"value": "Hi there"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.imBack, "Hi there")
	}

	func testCardActionWithPostBackJSON_decode_returnsPostBackCardAction() {
		// given
		let json = """
		{
			"type": "postBack",
			"value": "Hi there"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.postBack, "Hi there")
	}

	func testCardActionWithCallJSON_decode_returnsCallCardAction() {
		// given
		let json = """
		{
			"type": "call",
			"value": "tel:123123123123"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.call, URL(string: "tel:123123123123"))
	}

	func testCardActionWithPlayAudioJSON_decode_returnsPlayAudioCardAction() {
		// given
		let json = """
		{
			"type": "playAudio",
			"value": "http://example.com/audio.aac"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.playAudio, URL(string: "http://example.com/audio.aac"))
	}

	func testCardActionWithPlayVideoJSON_decode_returnsPlayVideoCardAction() {
		// given
		let json = """
		{
			"type": "playVideo",
			"value": "http://example.com/video.mp4"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.playVideo, URL(string: "http://example.com/video.mp4"))
	}

	func testCardActionWithShowImageJSON_decode_returnsShowImageCardAction() {
		// given
		let json = """
		{
			"type": "showImage",
			"value": "http://example.com/image.jpg"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.showImage, URL(string: "http://example.com/image.jpg"))
	}

	func testCardActionWithDownloadFileJSON_decode_returnsDownloadFileCardAction() {
		// given
		let json = """
		{
			"type": "downloadFile",
			"value": "http://example.com/resume.pdf"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.downloadFile, URL(string: "http://example.com/resume.pdf"))
	}

	func testCardActionWithSignInJSON_decode_returnsSigninCardAction() {
		// given
		let json = """
		{
			"type": "signin",
			"value": "http://example.com/oauth/authorize"
		}
		""".data(using: .utf8)!
		let decoder = JSONDecoder()

		// when
		let cardAction = try? decoder.decode(CardAction.self, from: json)

		// then
		XCTAssertEqual(cardAction?.signin, URL(string: "http://example.com/oauth/authorize"))
	}
}

private extension CardAction {
	var openURL: URL? {
		switch action {
		case .open(let value):
			return value
		default:
			return nil
		}
	}

	var imBack: String? {
		switch action {
		case .imBack(let value):
			return value
		default:
			return nil
		}
	}

	var postBack: String? {
		switch action {
		case .postBack(let value):
			return value
		default:
			return nil
		}
	}

	var call: URL? {
		switch action {
		case .call(let value):
			return value
		default:
			return nil
		}
	}

	var playAudio: URL? {
		switch action {
		case .playAudio(let value):
			return value
		default:
			return nil
		}
	}

	var playVideo: URL? {
		switch action {
		case .playVideo(let value):
			return value
		default:
			return nil
		}
	}

	var showImage: URL? {
		switch action {
		case .showImage(let value):
			return value
		default:
			return nil
		}
	}

	var downloadFile: URL? {
		switch action {
		case .downloadFile(let value):
			return value
		default:
			return nil
		}
	}

	var signin: URL? {
		switch action {
		case .signin(let value):
			return value
		default:
			return nil
		}
	}
}
