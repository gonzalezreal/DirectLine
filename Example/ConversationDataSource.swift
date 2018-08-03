//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import UIKit

final class ConversationDataSource: NSObject {
	private var messages: [Message] = []

	func tableView(_ tableView: UITableView, appendMessage message: Message) {
		messages.append(message)

		let indexPath = IndexPath(row: messages.count - 1, section: 0)
		let animation = UITableView.RowAnimation(direction: message.direction)

		tableView.insertRows(at: [indexPath], with: animation)
		tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
	}
}

extension ConversationDataSource: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		precondition(section == 0)
		return messages.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		precondition(indexPath.section == 0)

		let message = messages[indexPath.row]

		switch message.direction {
		case .incoming:
			let cell = tableView.dequeueReusableCell(IncomingMessageCell.self, for: indexPath)
			cell.message = message.text
			return cell
		case .outgoing:
			let cell = tableView.dequeueReusableCell(OutgoingMessageCell.self, for: indexPath)
			cell.message = message.text
			return cell
		}
	}
}

private extension UITableView.RowAnimation {
	init(direction: Message.Direction) {
		switch direction {
		case .outgoing:
			self = .right
		case .incoming:
			self = .left
		}
	}
}
