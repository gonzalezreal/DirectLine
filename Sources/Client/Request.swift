//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

internal enum RequestMethod: String {
	case get = "GET"
	case post = "POST"
}

/// A DirectLine request.
internal struct Request<Body: Encodable, Response: Decodable> {
	let token: String
	let method: RequestMethod
	let path: String
	let parameters: [String: String]
	let body: Body?

	init(token: String, method: RequestMethod, path: String, parameters: [String: String] = [:], body: Body? = nil) {
		self.token = token
		self.method = method
		self.path = path
		self.parameters = parameters
		self.body = body
	}
}
