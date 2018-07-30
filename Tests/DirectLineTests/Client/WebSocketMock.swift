//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

@testable import DirectLine
import Foundation

final class WebSocketMock: WebSocket {
	private(set) var openCount = 0
	private(set) var closeCount = 0

	var didReceiveMessage: (Data) -> Void = { _ in }
	var didFail: (Error) -> Void = { _ in }
	var didClose: (Int) -> Void = { _ in }

	func open() {
		openCount += 1
	}

	func close() {
		closeCount += 1
	}
}
