import Foundation

/// Defines the URL to a media file's source.
public struct MediaURL: Decodable {

	/// URL to the source of the media file.
	public let url: URL

	/// Hint that describes the media's content.
	public let profile: String?
}
