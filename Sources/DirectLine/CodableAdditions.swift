import Foundation

internal extension KeyedDecodingContainer {
    // Decode null or not specified array into an empty array
    func decode<A>(_: A.Type, forKey key: Key) throws -> A where A: Decodable, A: RangeReplaceableCollection {
        if let value = try decodeIfPresent(A.self, forKey: key) {
            return value
        } else {
            return A()
        }
    }
}

internal extension KeyedEncodingContainer {
    // Do not encode array if empty
    mutating func encode<A>(_ value: A, forKey key: Key) throws where A: Encodable, A: Collection {
        guard !value.isEmpty else { return }
        try encode(value, forKey: key)
    }
}
