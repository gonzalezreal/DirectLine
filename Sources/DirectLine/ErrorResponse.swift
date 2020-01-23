import SimpleNetworking
import Foundation

public struct ErrorResponse: Codable, Equatable {
    public struct ErrorCode: Codable, Equatable, Hashable, RawRepresentable {
        public let rawValue: String

        public init?(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public static let tokenExpired = ErrorCode(rawValue: "TokenExpired")!
        public static let badArgument = ErrorCode(rawValue: "BadArgument")!
    }
    
    /// Error information.
    public struct Error: Codable, Equatable {
        /// Error code.
        public let code: ErrorCode
        
        /// A description of the error.
        public let message: String?
    }
    
    /// An `Error` value that contains information about the error.
    public let error: Error
}

public extension BadStatusError {
    var errorResponse: ErrorResponse? {
        try? JSONDecoder().decode(ErrorResponse.self, from: data)
    }
}
