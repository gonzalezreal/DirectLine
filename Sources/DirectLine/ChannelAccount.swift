import Foundation

/// Defines a bot or user account on the channel.
public struct ChannelAccount: Codable, Equatable {
    public struct Role: Codable, Equatable, Hashable, RawRepresentable {
        public let rawValue: String

        public init?(rawValue: String) {
            self.rawValue = rawValue
        }

        public static let user = Role(rawValue: "user")!
        public static let bot = Role(rawValue: "bot")!
    }

    /// Unique ID for the user or bot on this channel.
    public let id: String?

    /// Display-friendly name of the bot or user.
    public let name: String?

    /// This account's object ID within Azure Active Directory.
    public let aadObjectId: String?

    /// Role of the entity behind the account.
    public let role: Role?

    public init(id: String? = nil, name: String? = nil, aadObjectId: String? = nil, role: Role? = nil) {
        self.id = id
        self.name = name
        self.aadObjectId = aadObjectId
        self.role = role
    }
}
