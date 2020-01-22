import Foundation

/// A response containing a resource identifier.
public struct ResourceResponse: Codable, Equatable {
    /// Id of the resource
    public let id: String
}
