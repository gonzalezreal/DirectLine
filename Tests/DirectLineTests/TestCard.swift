import Foundation

/// Sample card for testing.
struct TestCard: Codable, Equatable {
    static let contentType = "application/vnd.gonzalezreal.card.test"

    let foo: String
}
