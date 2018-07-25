//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

/// Defines an action to perform.
public struct CardAction {
	/// Enumerates the different types of actions.
	///
	/// - open: URL to be opened in the built-in browser.
	/// - imBack: Text of the message to send to the bot (from the user who clicked the button or tapped the card).
	/// - postBack: Text of the message to send to the bot (from the user who clicked the button or tapped the card).
	/// - call: Destination for a phone call.
	/// - playAudio: URL of audio to be played.
	/// - playVideo: URL of video to be played.
	/// - showImage: URL of image to be displayed.
	/// - download: URL of file to be downloaded.
	/// - signin: URL of OAuth flow to be initiated.
	public enum ActionType {
		case open(URL)
		case imBack(String)
		case postBack(String)
		case call(URL)
		case playAudio(URL)
		case playVideo(URL)
		case showImage(URL)
		case download(URL)
		case signin(URL)
	}

	/// URL of an image to display on the button. Only applicable for a button's action.
	public let image: URL?

	/// Text for the action.
	public let text: String?

	/// Text of the button. Only applicable for a button's action.
	public let title: String?

	/// The type of action to perform.
	public let type: ActionType
}

extension CardAction: Decodable {
	private enum CodingKeys: String, CodingKey {
		case image, text, title, type, value
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		image = try container.decodeIfPresent(URL.self, forKey: .image)
		text = try container.decodeIfPresent(String.self, forKey: .text)
		title = try container.decodeIfPresent(String.self, forKey: .title)

		let type = try container.decode(String.self, forKey: .type)

		switch type {
		case "openUrl":
			let value = try container.decode(URL.self, forKey: .value)
			self.type = .open(value)
		case "imBack":
			let value = try container.decode(String.self, forKey: .value)
			self.type = .imBack(value)
		case "postBack":
			let value = try container.decode(String.self, forKey: .value)
			self.type = .postBack(value)
		case "call":
			let value = try container.decode(URL.self, forKey: .value)
			self.type = .call(value)
		case "playAudio":
			let value = try container.decode(URL.self, forKey: .value)
			self.type = .playAudio(value)
		case "playVideo":
			let value = try container.decode(URL.self, forKey: .value)
			self.type = .playVideo(value)
		case "showImage":
			let value = try container.decode(URL.self, forKey: .value)
			self.type = .showImage(value)
		case "downloadFile":
			let value = try container.decode(URL.self, forKey: .value)
			self.type = .download(value)
		case "signin":
			let value = try container.decode(URL.self, forKey: .value)
			self.type = .signin(value)
		default:
			let context = DecodingError.Context(codingPath: [CodingKeys.type], debugDescription: "Unknown action type: \(type)")
			throw DecodingError.dataCorrupted(context)
		}
	}
}
