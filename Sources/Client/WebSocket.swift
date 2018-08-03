//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import os.log
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
	func webSocketDidOpen(_ webSocket: SRWebSocket) {
		os_log("didOpen: %{public}@", log: .wss, type: .debug, webSocket.url!.absoluteString)
	}

	func webSocket(_ webSocket: SRWebSocket, didReceiveMessageWith string: String) {
		guard !string.isEmpty else { return }

		os_log("didReceiveMessage:\n%{public}@\n", log: .wss, type: .debug, string)
		didReceiveMessage(string.data(using: .utf8)!)
	}

	func webSocket(_ webSocket: SRWebSocket, didFailWithError error: Error) {
		os_log("didFailWithError: %{public}@", log: .wss, type: .error, error.localizedDescription)
		didFail(error)
	}

	func webSocket(_ webSocket: SRWebSocket, didCloseWithCode code: Int, reason: String?, wasClean: Bool) {
		os_log("didCloseWithCode: %d", log: .wss, type: .debug, code)
		didClose(code)
	}
}

private extension OSLog {
	static let wss = OSLog(subsystem: "com.gonzalezreal.DirectLine.WS", category: "DirectLine.WS")
}
