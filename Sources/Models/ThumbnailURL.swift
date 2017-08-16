import Foundation

/// Defines the URL to an image's source.
public struct ThumbnailURL: Decodable {

	/// Description of the image.
	public let alt: String?

	/// URL to the source of the image.
	public let url: URL
}
