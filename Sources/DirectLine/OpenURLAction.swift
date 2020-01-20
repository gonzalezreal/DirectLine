import Foundation

/// Represents a hyperlink to be handled by the client.
public struct OpenURLAction: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case title, image
        case url = "value"
    }

    /// Text to be displayed on the button's face.
    public let title: String?

    /// Image to be displayed on the button's face.
    public let image: URL?

    /// The URL to be opened in the built-in browser.
    public let url: URL
}
