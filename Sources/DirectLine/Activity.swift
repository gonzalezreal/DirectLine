import Foundation

/// An Activity is the basic communication type for the Bot Framework 3.0 protocol.
public struct Activity<ChannelData> {
    /// Type of activity.
    public let type: ActivityType

    /// ID that uniquely identifies the activity on the channel.
    public let id: String?

    /// Date and time that the message was sent in the UTC time zone.
    public let timestamp: Date?

    /// Identifies the sender of the message.
    public let from: ChannelAccount

    /// The conversation to which the activity belongs.
    public let conversation: ConversationAccount?

    /// Identifies the prior activity to which the current activity is a reply.
    public let replyToId: String?

    /// Contains channel-specific content.
    public let channelData: ChannelData?
}

extension Activity {
    public init(type: ActivityType, from: ChannelAccount, channelData: ChannelData?) {
        self.type = type
        id = nil
        timestamp = nil
        self.from = from
        conversation = nil
        replyToId = nil
        self.channelData = channelData
    }
}

extension Activity where ChannelData == Empty {
    public init(type: ActivityType, from: ChannelAccount) {
        self.type = type
        id = nil
        timestamp = nil
        self.from = from
        conversation = nil
        replyToId = nil
        channelData = nil
    }
}

extension Activity: Codable where ChannelData: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, timestamp, from, conversation, replyToId, channelData
    }

    public init(from decoder: Decoder) throws {
        type = try ActivityType(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(String.self, forKey: .id)
        timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp)
        from = try container.decode(ChannelAccount.self, forKey: .from)
        conversation = try container.decodeIfPresent(ConversationAccount.self, forKey: .conversation)
        replyToId = try container.decodeIfPresent(String.self, forKey: .replyToId)
        channelData = try container.decodeIfPresent(ChannelData.self, forKey: .channelData)
    }

    public func encode(to encoder: Encoder) throws {
        try type.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(from, forKey: .from)
        try container.encodeIfPresent(conversation, forKey: .conversation)
        try container.encodeIfPresent(replyToId, forKey: .replyToId)
        try container.encodeIfPresent(channelData, forKey: .channelData)
    }
}

extension Activity: Equatable where ChannelData: Equatable {}
