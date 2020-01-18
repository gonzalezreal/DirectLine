import Foundation

/// An Activity is the basic communication type for the Bot Framework 3.0 protocol.
public struct Activity<ChannelData>: Codable, Equatable where ChannelData: Codable, ChannelData: Equatable {}
