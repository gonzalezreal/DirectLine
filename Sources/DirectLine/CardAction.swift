import Foundation

/// Represents a clickable or interactive button for use within cards or as suggested actions.
public enum CardAction: Equatable {
    case messageBack(MessageBackAction)
    case imBack(IMBackAction)
    case postBack(PostBackAction)
    case openURL(URLAction)
    case downloadFile(URLAction)
    case showImage(URLAction)
    case signIn(URLAction)
    case playAudio(URLAction)
    case playVideo(URLAction)
    case call(URLAction)
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
        case "openUrl":
            self = try .openURL(URLAction(from: decoder))
        case "downloadFile":
            self = try .downloadFile(URLAction(from: decoder))
        case "showImage":
            self = try .showImage(URLAction(from: decoder))
        case "signin":
            self = try .signIn(URLAction(from: decoder))
        case "playAudio":
            self = try .playAudio(URLAction(from: decoder))
        case "playVideo":
            self = try .playVideo(URLAction(from: decoder))
        case "call":
            self = try .call(URLAction(from: decoder))
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
        case let .openURL(action):
            try container.encode("openUrl", forKey: .type)
            try action.encode(to: encoder)
        case let .downloadFile(action):
            try container.encode("downloadFile", forKey: .type)
            try action.encode(to: encoder)
        case let .showImage(action):
            try container.encode("showImage", forKey: .type)
            try action.encode(to: encoder)
        case let .signIn(action):
            try container.encode("signin", forKey: .type)
            try action.encode(to: encoder)
        case let .playAudio(action):
            try container.encode("playAudio", forKey: .type)
            try action.encode(to: encoder)
        case let .playVideo(action):
            try container.encode("playVideo", forKey: .type)
            try action.encode(to: encoder)
        case let .call(action):
            try container.encode("call", forKey: .type)
            try action.encode(to: encoder)
        case .unknown:
            fatalError("Invalid CardAction.")
        }
    }
}
