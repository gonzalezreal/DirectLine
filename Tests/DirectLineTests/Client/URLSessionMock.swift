//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

final class URLSessionDataTaskMock: URLSessionDataTask {
	private(set) var resumeCount = 0
	var resumeStub: (() -> Void)?

	private(set) var cancelCount = 0
	var cancelStub: (() -> Void)?

	override func resume() {
		resumeCount += 1
		resumeStub?()
	}

	override func cancel() {
		cancelCount += 1
		cancelStub?()
	}
}

final class URLSessionMock: URLSession {
	private enum Stub {
		case response(Data, HTTPURLResponse)
		case error(Error)
	}

	let dataTask = URLSessionDataTaskMock()

	private(set) var requests: [URLRequest] = []
	private var stubs: [URLRequest: Stub] = [:]

	func stub(data: Data, statusCode: Int, with request: URLRequest) {
		stubs[request] = .response(data, HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!)
	}

	func stub(error: Error, with request: URLRequest) {
		stubs[request] = .error(error)
	}

	override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		requests.append(request)

		if let stub = stubs[request] {
			switch stub {
			case let .response(data, response):
				completionHandler(data, response, nil)
			case let .error(error):
				completionHandler(nil, nil, error)
			}
		}

		return dataTask
	}
}
