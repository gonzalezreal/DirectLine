//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

@testable import DirectLine

private func equalDump<T>(_ lhs: T, _ rhs: T) -> Bool {
	var (ldump, rdump) = ("", "")
	dump(lhs, to: &ldump)
	dump(rhs, to: &rdump)

	return ldump == rdump
}

extension DirectLineError: Equatable {
	public static func == (lhs: DirectLineError, rhs: DirectLineError) -> Bool {
		return equalDump(lhs, rhs)
	}
}

extension Attachment.Content: Equatable {
	public static func == (lhs: Attachment.Content, rhs: Attachment.Content) -> Bool {
		return equalDump(lhs, rhs)
	}
}
