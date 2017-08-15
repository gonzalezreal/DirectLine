import Foundation

/// Defines a key-value pair that contains a fact.
public struct Fact: Decodable {

	/// Name of the fact.
	///
	/// For example, **Check-in**. The key is used as a label when displaying the fact's value.
	public let key: String

	/// Value of the fact.
	///
	/// For example, **10 October 2016**.
	public let value: String
}
