import Foundation

/// Represents a text response that is added to the chat feed.
public struct IMBackAction: Codable, Equatable {
    /// Text to be displayed on the button's face.
    public let title: String?

    /// Image to be displayed on the button's face.
    public let image: URL?

    /// Text content to be sent to a bot when the button is clicked.
    public let value: String
}
