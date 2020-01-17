import Foundation
import SimpleNetworking

// MARK: - Tokens

public extension Endpoint where Output == Conversation {
    /// Generate a token for a new conversation.
    /// - Parameter secret: The secret of your Direct Line channel configuration.
    static func generateToken(secret: String) -> Endpoint {
        return Endpoint(method: .post,
                        path: "tokens/generate",
                        headers: [.authorization: "Bearer \(secret)"])
    }

    /// Generate a token for a new conversation.
    /// - Parameter secret: The secret of your Direct Line channel configuration.
    /// - Parameter tokenParameters: Parameters for creating a token.
    static func generateToken(secret: String, tokenParameters: TokenParameters) -> Endpoint {
        return Endpoint(method: .post,
                        path: "tokens/generate",
                        headers: [.authorization: "Bearer \(secret)"],
                        body: tokenParameters)
    }

    /// Refresh a token.
    /// - Parameter token: The token to be refreshed.
    static func refreshToken(_ token: String) -> Endpoint {
        return Endpoint(method: .post,
                        path: "tokens/refresh",
                        headers: [.authorization: "Bearer \(token)"])
    }
}
