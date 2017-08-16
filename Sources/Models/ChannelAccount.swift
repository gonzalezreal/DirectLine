import Foundation

/// Defines a bot or user account on the channel.
public struct ChannelAccount: Codable {

	/// ID that uniquely identifies the bot or user on the channel.
	public let id: String

	/// Name of the bot or user.
	public let name: String?

	public init(id: String, name: String? = nil) {
		self.id = id
		self.name = name
	}
}
