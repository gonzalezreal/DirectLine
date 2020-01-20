import Foundation

/// Represents a clickable or interactive button for use within cards or as suggested actions.
public enum CardAction: Equatable {
    case messageBack(MessageBackAction)
    case imBack(IMBackAction)
    case postBack(PostBackAction)
    case unknown
}

extension CardAction: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "messageBack":
            self = try .messageBack(MessageBackAction(from: decoder))
        case "imBack":
            self = try .imBack(IMBackAction(from: decoder))
        case "postBack":
            self = try .postBack(PostBackAction(from: decoder))
        default:
            self = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .messageBack(action):
            try container.encode("messageBack", forKey: .type)
            try action.encode(to: encoder)
        case let .imBack(action):
            try container.encode("imBack", forKey: .type)
            try action.encode(to: encoder)
        case let .postBack(action):
            try container.encode("postBack", forKey: .type)
            try action.encode(to: encoder)
        case .unknown:
            fatalError("Invalid CardAction.")
        }
    }
}
