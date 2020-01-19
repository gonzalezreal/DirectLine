import Foundation

/// Defines the options from which a user can choose.
public struct SuggestedActions: Codable, Equatable {
    /// IDs of the recipients to whom the suggested actions should be displayed.
    public let to: [String]

    /// List of actions to be displayed.
    public let actions: [CardAction]
}
