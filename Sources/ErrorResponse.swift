import Foundation

public struct ErrorResponse: Decodable {
	public struct Error: Decodable {
		public let code: String
		public let message: String
	}

	public let error: Error
}
