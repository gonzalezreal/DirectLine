import Foundation

public enum MediaType: CustomStringConvertible {
	case imagePNG
	case imageJPG
	case imageJPEG
	case imageGIF
	case audioMPEG
	case audioMP4
	case videoMP4
	case other(String)

	internal init(stringValue: String) {
		switch stringValue {
		case "image/png":
			self = .imagePNG
		case "image/jpg":
			self = .imageJPG
		case "image/jpeg":
			self = .imageJPEG
		case "image/gif":
			self = .imageGIF
		case "audio/mpeg":
			self = .audioMPEG
		case "audio/mp4":
			self = .audioMP4
		case "video/mp4":
			self = .videoMP4
		default:
			self = .other(stringValue)
		}
	}

	public var description: String {
		switch self {
		case .imagePNG:
			return "image/png"
		case .imageJPG:
			return "image/jpg"
		case .imageJPEG:
			return "image/jpeg"
		case .imageGIF:
			return "image/gif"
		case .audioMPEG:
			return "audio/mpeg"
		case .audioMP4:
			return "audio/mp4"
		case .videoMP4:
			return "video/mp4"
		case let .other(value):
			return value
		}
	}
}

/// A media file.
public struct Media: Codable {

	/// The media type of the content.
	public let contentType: MediaType

	/// URL for the content of the attachment.
	public let contentURL: URL

	public init(contentType: MediaType, contentURL: URL) {
		self.contentType = contentType
		self.contentURL = contentURL
	}

	private enum CodingKeys: String, CodingKey {
		case contentType
		case contentURL = "contentUrl"
	}
}

public extension Media {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let contentType = try container.decode(String.self, forKey: .contentType)
		let contentURL = try container.decode(URL.self, forKey: .contentURL)

		self.init(contentType: MediaType(stringValue: contentType),
		          contentURL: contentURL)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(contentType.description, forKey: .contentType)
		try container.encode(contentURL, forKey: .contentURL)
	}
}
