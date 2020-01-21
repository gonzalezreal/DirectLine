import Foundation

public enum ActivityType: Equatable {
    case message(MessageActivity)
    case endOfConversation(EndOfConversationActivity)
    case typing
    case unknown
}

extension ActivityType: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "message":
            self = try .message(MessageActivity(from: decoder))
        case "endOfConversation":
            self = try .endOfConversation(EndOfConversationActivity(from: decoder))
        case "typing":
            self = .typing
        default:
            self = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .message(messageActivity):
            try container.encode("message", forKey: .type)
            try messageActivity.encode(to: encoder)
        case let .endOfConversation(endOfConversationActivity):
            try container.encode("endOfConversation", forKey: .type)
            try endOfConversationActivity.encode(to: encoder)
        case .typing:
            try container.encode("typing", forKey: .type)
        case .unknown:
            fatalError("Invalid activity type.")
        }
    }
}
