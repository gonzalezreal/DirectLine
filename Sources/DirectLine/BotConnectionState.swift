import Foundation

public enum BotConnectionState {
    case uninitialized
    case connecting
    case connected
    case expiredToken
    case failedToConnect
    case closed
}
