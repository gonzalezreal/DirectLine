import Foundation
import SimpleNetworking

public enum Auth {
    case secret(String)
    case token(String)

    public var value: String {
        switch self {
        case let .secret(value):
            return value
        case let .token(value):
            return value
        }
    }
}

// MARK: - Tokens

public extension Endpoint where Output == Conversation {
    /// Generate a token for a new conversation.
    /// - Parameter secret: The secret of your Direct Line channel configuration.
    static func generateToken(secret: String) -> Endpoint {
        Endpoint(method: .post,
                 path: "tokens/generate",
                 headers: [.authorization: "Bearer \(secret)"])
    }

    /// Generate a token for a new conversation.
    /// - Parameters:
    ///   - secret: The secret in your Direct Line channel configuration.
    ///   - tokenParameters: Parameters for creating a token.
    static func generateToken(secret: String, tokenParameters: TokenParameters) -> Endpoint {
        Endpoint(method: .post,
                 path: "tokens/generate",
                 headers: [.authorization: "Bearer \(secret)"],
                 body: tokenParameters)
    }

    /// Refresh a token.
    /// - Parameter token: The token to be refreshed.
    static func refreshToken(_ token: String) -> Endpoint {
        Endpoint(method: .post,
                 path: "tokens/refresh",
                 headers: [.authorization: "Bearer \(token)"])
    }
}

// MARK: - Conversations

public extension Endpoint where Output == Conversation {
    /// Start a new conversation.
    /// - Parameter auth: The secret in your Direct Line channel configuration or a token obtained via the `generateToken` endpoint.
    static func startConversation(_ auth: Auth) -> Endpoint {
        Endpoint(method: .post,
                 path: "conversations",
                 headers: [.authorization: "Bearer \(auth.value)"])
    }

    /// Start a new conversation.
    /// - Parameters:
    ///   - secret: The secret in your Direct Line channel configuration.
    ///   - tokenParameters: Parameters for creating a token.
    static func startConversation(secret: String, tokenParameters: TokenParameters) -> Endpoint {
        Endpoint(method: .post,
                 path: "conversations",
                 headers: [.authorization: "Bearer \(secret)"],
                 body: tokenParameters)
    }
}
