import Foundation

/// Defines a set of activities.
public struct ActivitySet: Decodable {

	/// Array of Activity objects.
	public let activities: [Activity]

	/// Maximum watermark of activities within the set.
	///
	/// A client may use the `watermark` value to indicate the most recent message
	/// it has seen either when retrieving activities from the bot or when generating
	/// a new WebSocket stream URL.
	public let watermark: String?
}
