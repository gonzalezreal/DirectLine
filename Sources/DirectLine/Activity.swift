import Foundation

/// An Activity is the basic communication type for the Bot Framework 3.0 protocol.
public struct Activity<ChannelData> {
    /// Contains the activity type.
    public let type: ActivityType
}

extension Activity: Codable where ChannelData: Codable {
    public init(from decoder: Decoder) throws {
        type = try ActivityType(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try type.encode(to: encoder)
    }
}

extension Activity: Equatable where ChannelData: Equatable {}
