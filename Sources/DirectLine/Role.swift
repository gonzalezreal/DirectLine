import Foundation

public struct Role: Codable, Equatable, Hashable, RawRepresentable {
    public let rawValue: String

    public init?(rawValue: String) {
        self.rawValue = rawValue
    }

    public static let user = Role(rawValue: "user")!
    public static let bot = Role(rawValue: "bot")!
}
