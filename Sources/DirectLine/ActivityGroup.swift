import Foundation

/// A collection of activities.
public struct ActivityGroup<ChannelData>: Codable, Equatable where ChannelData: Codable, ChannelData: Equatable {
    /// Activities.
    public let activities: [Activity<ChannelData>]

    /// Maximum watermark of activities within this collection.
    public let watermark: String
}
