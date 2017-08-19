import Foundation
@testable import DirectLine

private func equalDump<T>(_ lhs: T, _ rhs: T) -> Bool {
	var (ldump, rdump) = ("", "")
	dump(lhs, to: &ldump)
	dump(rhs, to: &rdump)

	return ldump == rdump
}

extension DirectLineClientError: Equatable {
	public static func ==(lhs: DirectLineClientError, rhs: DirectLineClientError) -> Bool {
		return equalDump(lhs, rhs)
	}
}

extension Conversation: Equatable {
	public static func ==(lhs: Conversation, rhs: Conversation) -> Bool {
		return equalDump(lhs, rhs)
	}
}
