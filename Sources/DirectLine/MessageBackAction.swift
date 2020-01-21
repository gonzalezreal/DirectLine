import Foundation

/// Represents a text response to be sent via the chat system.
public struct MessageBackAction: Codable, Equatable {
    /// Text to be displayed on the button's face.
    public let title: String?

    /// Image to be displayed on the button's face.
    public let image: URL?

    /// Text content to be sent to a bot and included in the chat feed when the button is clicked.
    public let text: String?

    /// Text content to be included in the chat feed when the button is clicked.
    public let displayText: String?

    /// Programmatic content to be sent to a bot when the button is clicked.
    public let value: AnyValue?
}
