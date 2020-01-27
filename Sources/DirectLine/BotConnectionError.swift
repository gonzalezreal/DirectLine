import Foundation
import SimpleNetworking

public enum BotConnectionError: Equatable, Error {
    case failedToConnect
    case tokenExpired
    case badArgument
    case conversationEnded
}

internal extension BotConnectionError {
    init(error: Error) {
        if let botConnectionError = error as? BotConnectionError {
            self = botConnectionError
        } else if let badStatusError = error as? BadStatusError, let errorResponse = badStatusError.errorResponse {
            switch errorResponse.error.code {
            case .tokenExpired:
                self = .tokenExpired
            case .badArgument:
                self = .badArgument
            default:
                self = .failedToConnect
            }
        } else {
            self = .failedToConnect
        }
    }
}
