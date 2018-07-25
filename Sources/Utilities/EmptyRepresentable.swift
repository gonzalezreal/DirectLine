//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

/// A type that has an "empty" representation.
public protocol EmptyRepresentable {
	static func empty() -> Self
}

extension Array: EmptyRepresentable {
	public static func empty() -> Array<Element> {
		return Array()
	}
}

extension KeyedDecodingContainer {
	public func decode<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T where T: Decodable & EmptyRepresentable {
		if let result = try decodeIfPresent(T.self, forKey: key) {
			return result
		} else {
			return T.empty()
		}
	}
}
