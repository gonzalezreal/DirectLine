//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import SocketRocket

internal protocol WebSocket: class {
	var didReceiveMessage: (Data) -> Void { get set }
	var didFail: (Error) -> Void { get set }
	var didClose: (Int) -> Void { get set }

	func open()
	func close()
}

internal final class WebSocketImpl: NSObject, WebSocket {
	var didReceiveMessage: (Data) -> Void = { _ in }
	var didFail: (Error) -> Void = { _ in }
	var didClose: (Int) -> Void = { _ in }

	private let impl: SRWebSocket

	init(url: URL) {
		impl = SRWebSocket(url: url)
		impl.delegateDispatchQueue = DispatchQueue(label: "com.gonzalezreal.DirectLine.WebSocketImpl")
	}

	func open() {
		impl.delegate = self
		impl.open()
	}

	func close() {
		impl.close()
		impl.delegate = nil
	}
}

extension WebSocketImpl: SRWebSocketDelegate {
	func webSocket(_ webSocket: SRWebSocket, didReceiveMessageWith string: String) {
		guard !string.isEmpty else { return }
		didReceiveMessage(string.data(using: .utf8)!)
	}

	func webSocket(_ webSocket: SRWebSocket, didFailWithError error: Error) {
		didFail(error)
	}

	func webSocket(_ webSocket: SRWebSocket, didCloseWithCode code: Int, reason: String?, wasClean: Bool) {
		didClose(code)
	}
}
