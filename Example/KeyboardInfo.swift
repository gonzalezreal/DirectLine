//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import UIKit

struct KeyboardInfo {
	let animationDuration: TimeInterval
	let frameHeight: Int
}

extension KeyboardInfo {
	init?(_ notification: Notification) {
		guard let userInfo = notification.userInfo,
			let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
			let frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
			return nil
		}

		animationDuration = duration
		frameHeight = Int(frameEnd.height)
	}
}
