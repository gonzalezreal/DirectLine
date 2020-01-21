import Foundation

public struct URLAction: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case title, image
        case url = "value"
    }

    /// Text to be displayed on the button's face.
    public let title: String?

    /// Image to be displayed on the button's face.
    public let image: URL?

    /// The url for this action.
    public let url: URL
}
