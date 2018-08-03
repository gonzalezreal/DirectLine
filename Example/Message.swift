//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

struct Message {
	enum Direction {
		case incoming, outgoing
	}

	let direction: Direction
	let text: String
}
