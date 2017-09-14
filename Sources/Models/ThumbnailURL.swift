import Foundation

/// Defines the URL to an image's source.
public struct ThumbnailURL: Decodable {

	/// URL to the source of the image.
	public let url: URL

	/// Description of the image.
	public let description: String?

	private enum CodingKeys: String, CodingKey {
		case url
		case description = "alt"
	}
}
