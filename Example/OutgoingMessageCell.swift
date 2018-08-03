//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import UIKit

class OutgoingMessageCell: UITableViewCell, ReusableView {
	private enum Constants {
		static let trailing: CGFloat = -16
		static let top: CGFloat = 4
		static let bottom: CGFloat = -4
		static let widthRatio: CGFloat = 0.75
	}

	var message: String {
		get { return messageView.text }
		set { messageView.text = newValue }
	}

	private let messageView = MessageView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		messageView.style = .outgoing

		contentView.addSubview(messageView, constraints: [
			messageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.top),
			messageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailing),
			messageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottom),
			messageView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: Constants.widthRatio)
		])
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
