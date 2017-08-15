import Foundation

/// An error response.
public struct ErrorResponse: Decodable {

	/// Defines an error.
	public struct Error: Decodable {

		/// Error code.
		public let code: String

		/// A description of the error.
		public let message: String
	}

	/// An Error object that contains information about the error.
	public let error: Error
}
