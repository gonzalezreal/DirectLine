//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

/// Defines the options from which a user can choose.
public struct SuggestedActions: Decodable {
	/// Array of `CardAction` values that define the suggested actions.
	public let actions: [CardAction]

	/// Array of strings that contains the IDs of the recipients to whom the suggested actions should be displayed.
	public let to: [String]
}
