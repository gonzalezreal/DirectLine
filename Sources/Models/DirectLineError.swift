//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

public enum DirectLineError: Error {
	case timedOut
	case cannotConnect
	case connectionLost
	case notConnected
	case invalidToken
	case botNotAvailable
	case noConversation
	case badStatus(Int)
	case other(Error)
}

internal extension DirectLineError {
	init(error: Error) {
		switch error {
		case let urlError as URLError:
			switch urlError.code {
			case .timedOut:
				self = .timedOut
			case .cannotConnectToHost:
				self = .cannotConnect
			case .networkConnectionLost:
				self = .connectionLost
			case .notConnectedToInternet:
				self = .notConnected
			default:
				self = .other(error)
			}
		default:
			self = .other(error)
		}
	}

	init(statusCode: Int) {
		switch statusCode {
		case 403:
			self = .invalidToken
		case 502:
			self = .botNotAvailable
		default:
			self = .badStatus(statusCode)
		}
	}
}
