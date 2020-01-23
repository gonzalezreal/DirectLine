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

    /// Gets information about an existing conversation and also generates a new WebSocket stream URL that a client may use to reconnect to a conversation.
    /// - Parameters:
    ///   - auth: The secret in your Direct Line channel configuration or a token obtained via the `generateToken` endpoint.
    ///   - conversationId: A conversation identifier.
    ///   - watermark: Indicates the most recent message seen by the client.
    static func conversation(_ auth: Auth, conversationId: String, watermark: String? = nil) -> Endpoint {
        Endpoint(method: .get,
                 path: "conversations/\(conversationId)",
                 headers: [.authorization: "Bearer \(auth.value)"],
                 queryParameters: watermark.map { ["watermark": $0] } ?? [:])
    }
}

// MARK: - Activities

public extension Endpoint {
    /// Get activities in a conversation.
    /// - Parameters:
    ///   - type: Channel data type.
    ///   - token: A token obtained via the `generateToken` or `startConversation` endpoints.
    ///   - conversationId: A conversation identifier.
    ///   - watermark: Only returns activities newer than this watermark.
    static func activities<ChannelData>(_: ChannelData.Type, token: String, conversationId: String, watermark: String? = nil) -> Endpoint<Output> where Output == ActivityGroup<ChannelData> {
        Endpoint(method: .get,
                 path: "conversations/\(conversationId)/activities",
                 headers: [.authorization: "Bearer \(token)"],
                 queryParameters: watermark.map { ["watermark": $0] } ?? [:])
    }
}

public extension Endpoint where Output == ActivityGroup<Empty> {
    /// Get activities in a conversation.
    /// - Parameters:
    ///   - token: A token obtained via the `generateToken` or `startConversation` endpoints.
    ///   - conversationId: A conversation identifier.
    ///   - watermark: Only returns activities newer than this watermark.
    static func activities(token: String, conversationId: String, watermark: String? = nil) -> Endpoint {
        activities(Empty.self, token: token, conversationId: conversationId, watermark: watermark)
    }
}

public extension Endpoint where Output == ResourceResponse {
    /// Send an activity.
    /// - Parameters:
    ///   - token: A token obtained via the `generateToken` or `startConversation` endpoints.
    ///   - conversationId: A conversation identifier.
    ///   - activity: Activity to send.
    static func postActivity<ChannelData>(token: String, conversationId: String, activity: Activity<ChannelData>) -> Endpoint where ChannelData: Codable {
        Endpoint(method: .post,
                 path: "conversations/\(conversationId)/activities",
                 headers: [.authorization: "Bearer \(token)"],
                 body: activity)
    }
}
