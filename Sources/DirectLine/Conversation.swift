import Foundation

/// An object representing a conversation or a conversation token.
public struct Conversation: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case conversationId, token
        case expiresIn = "expires_in"
        case streamURL = "streamUrl"
        case referenceGrammarId
    }

    /// Uniquely identifies the conversation for which the specified token is valid.
    public let conversationId: String

    /// Token that is valid for the specified conversation.
    public let token: String

    /// Number of seconds until the token expires.
    public let expiresIn: TimeInterval

    /// URL for the conversation's message stream.
    public let streamURL: URL?

    /// Identifier for the reference grammar for this bot.
    public let referenceGrammarId: String?
}
