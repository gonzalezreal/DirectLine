//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

/// Defines a list of activities.
internal struct ActivityList<ChannelData: Codable>: Decodable {
	/// Array of `Activity` values.
	let activities: [Activity<ChannelData>]

	/// Maximum watermark of activities within the set.
	///
	/// A client may use the `watermark` value to indicate the most recent message
	/// it has seen either when retrieving activities from the bot or when generating
	/// a new WebSocket stream URL.
	let watermark: String?
}
