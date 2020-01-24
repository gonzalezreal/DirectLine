import Foundation

public enum BotConnectionState: Equatable {
    case uninitialized
    case connecting
    case ready(Conversation)
    case failed(BotConnectionError)
}

internal extension BotConnectionState {
    var isReadyOrHasFailed: Bool {
        switch self {
        case .ready, .failed:
            return true
        default:
            return false
        }
    }

    func conversation() throws -> Conversation {
        switch self {
        case let .ready(conversation):
            return conversation
        case let .failed(error):
            throw error
        default:
            fatalError("Unexpected connection state: \(self)")
        }
    }
}
