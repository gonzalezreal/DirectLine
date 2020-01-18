import Foundation

public enum ActivityType: Equatable {
    case message(MessageActivity)
    case endOfConversation(EndOfConversationActivity)
    case typing
    case unknown
}

extension ActivityType: Decodable {
    public init(from _: Decoder) throws {
        fatalError()
    }
}

extension ActivityType: Encodable {
    public func encode(to _: Encoder) throws {
        fatalError()
    }
}
