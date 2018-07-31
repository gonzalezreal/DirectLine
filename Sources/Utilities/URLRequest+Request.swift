//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

internal extension URLRequest {
	init<Body>(baseURL: URL, request: Request<Body>) where Body: Encodable {
		let url = baseURL.appendingPathComponent(request.path)
		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!

		if !request.parameters.isEmpty {
			components.queryItems = request.parameters.map(URLQueryItem.init)
		}

		self.init(url: components.url!)

		httpMethod = request.method.rawValue
		addValue("Bearer \(request.token)", forHTTPHeaderField: "Authorization")

		if let body = request.body {
			addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

			let encoder = JSONEncoder()
			encoder.dateEncodingStrategy = .formatted(.iso8601WithFractionalSeconds)
			httpBody = try? encoder.encode(body)
		}
	}
}
