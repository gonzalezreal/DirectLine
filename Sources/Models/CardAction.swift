import Foundation

/// Defines an action to perform.
public struct CardAction {

	/// Enumerates the valid actions.
	///
	/// - open: URL to be opened in the built-in browser.
	/// - imBack: Text of the message to send to the bot (from the user who clicked the button or tapped the card).
	/// - postBack: Text of the message to send to the bot (from the user who clicked the button or tapped the card).
	/// - call: Destination for a phone call.
	/// - playAudio: URL of audio to be played.
	/// - playVideo: URL of video to be played.
	/// - showImage: URL of image to be displayed.
	/// - downloadFile: URL of file to be downloaded.
	/// - signin: URL of OAuth flow to be initiated.
	public enum Action {
		case open(URL)
		case imBack(String)
		case postBack(String)
		case call(URL)
		case playAudio(URL)
		case playVideo(URL)
		case showImage(URL)
		case downloadFile(URL)
		case signin(URL)
	}

	/// The action to perform.
	public let action: Action

	/// Text of the button. Only applicable for a button's action.
	public let title: String?

	/// URL of an image to display on the button. Only applicable for a button's action.
	public let image: URL?
}

extension CardAction: Decodable {
	private enum CodingKeys: String, CodingKey {
		case type
		case title
		case image
		case value
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let type = try container.decode(String.self, forKey: .type)
		let action: Action

		switch type {
		case "openUrl":
			let value = try container.decode(URL.self, forKey: .value)
			action = .open(value)
		case "imBack":
			let value = try container.decode(String.self, forKey: .value)
			action = .imBack(value)
		case "postBack":
			let value = try container.decode(String.self, forKey: .value)
			action = .postBack(value)
		case "call":
			let value = try container.decode(URL.self, forKey: .value)
			action = .call(value)
		case "playAudio":
			let value = try container.decode(URL.self, forKey: .value)
			action = .playAudio(value)
		case "playVideo":
			let value = try container.decode(URL.self, forKey: .value)
			action = .playVideo(value)
		case "showImage":
			let value = try container.decode(URL.self, forKey: .value)
			action = .showImage(value)
		case "downloadFile":
			let value = try container.decode(URL.self, forKey: .value)
			action = .downloadFile(value)
		case "signin":
			let value = try container.decode(URL.self, forKey: .value)
			action = .signin(value)
		default:
			let context = DecodingError.Context(codingPath: [CodingKeys.type], debugDescription: "Unknown action type: \(type)")
			throw DecodingError.dataCorrupted(context)
		}

		let title = try container.decodeIfPresent(String.self, forKey: .title)
		let image = try container.decodeIfPresent(URL.self, forKey: .image)

		self.init(action: action, title: title, image: image)
	}
}
