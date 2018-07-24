//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

/// Defines a message that is exchanged between bot and user.
public struct Activity<ChannelData: Codable>: Codable {
	/// A value that contains channel-specific content.
	public let channelData: ChannelData?
}
