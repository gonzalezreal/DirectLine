import Foundation

/// Defines a conversation in a channel.
public struct ConversationAccount: Codable, Equatable {
    /// The ID that identifies the conversation.
    public let id: String

    /// Friendly name for the conversation within the channel.
    public let name: String?

    /// This account's object ID within Azure Active Directory (AAD).
    public let aadObjectId: String?

    /// Indicates whether the conversation contains more than two participants at the time the activity was generated.
    public let isGroup: Bool?

    /// Indicates the type of the conversation in channels that distinguish between conversation types.
    public let conversationType: String?

    /// Role of the entity behind the account.
    public let role: Role?

    public init(id: String, name: String? = nil, aadObjectId: String? = nil, isGroup: Bool? = nil, conversationType: String? = nil, role: Role? = nil) {
        self.id = id
        self.name = name
        self.aadObjectId = aadObjectId
        self.isGroup = isGroup
        self.conversationType = conversationType
        self.role = role
    }
}
