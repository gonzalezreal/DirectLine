import Foundation

/// Represents a response that is not added to the chat feed.
public struct PostBackAction: Codable, Equatable {
    /// Text to be displayed on the button's face.
    public let title: String?

    /// Image to be displayed on the button's face.
    public let image: URL?

    /// Content to be sent to a bot when the button is clicked.
    public let value: AnyValue
}
