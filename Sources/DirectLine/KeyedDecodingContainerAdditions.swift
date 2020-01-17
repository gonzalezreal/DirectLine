import Foundation

public extension KeyedDecodingContainer {
    func decode<A>(_: A.Type, forKey key: Key) throws -> A where A: Decodable, A: RangeReplaceableCollection {
        if let value = try decodeIfPresent(A.self, forKey: key) {
            return value
        } else {
            return A()
        }
    }
}
