import Foundation

/// Parameters for creating a token.
public struct TokenParameters: Codable, Equatable {
    /// User account to embed within the token.
    public let user: ChannelAccount

    /// Trusted origins to embed within the token.
    public let trustedOrigins: [String]

    public init(user: ChannelAccount, trustedOrigins: [String] = []) {
        self.user = user
        self.trustedOrigins = trustedOrigins
    }
}
