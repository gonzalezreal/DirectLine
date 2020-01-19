import Foundation

/// End of conversation activities signal the end of a conversation from the recipient's perspective.
public struct EndOfConversationActivity: Codable, Equatable {
    /// Optional text content to be communicated to a user.
    public let text: String?

    /// Describes why or how the conversation was ended.
    public let code: String?
}
