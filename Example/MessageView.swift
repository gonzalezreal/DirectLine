//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import UIKit

final class MessageView: UIView {
	enum Direction {
		case incoming, outgoing
	}

	var text: String {
		get { return textLabel.text ?? "" }
		set {
			textLabel.text = newValue
			invalidateIntrinsicContentSize()
		}
	}

	var direction: Direction = .incoming {
		didSet { didUpdateDirection() }
	}

	private let textLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setUp()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setUp()
	}

	override var intrinsicContentSize: CGSize {
		let textSize = textLabel.intrinsicContentSize
		return CGSize(width: Constants.contentInset.left + textSize.width + Constants.contentInset.right,
		              height: Constants.contentInset.top + textSize.height + Constants.contentInset.bottom)
	}
}

private extension MessageView {
	enum Constants {
		static let contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
		static let cornerRadius: CGFloat = 8
	}

	private func setUp() {
		backgroundColor = .clear
		layer.cornerRadius = Constants.cornerRadius

		textLabel.numberOfLines = 0
		textLabel.textAlignment = .natural
		textLabel.font = .preferredFont(forTextStyle: .callout)
		textLabel.setContentHuggingPriority(.required, for: .horizontal)
		textLabel.setContentHuggingPriority(.required, for: .vertical)

		addSubview(textLabel, constraints: textLabel.constraintsForEdges(to: self, inset: Constants.contentInset))
	}

	private func didUpdateDirection() {
		switch direction {
		case .outgoing:
			backgroundColor = .outgoing
			textLabel.textColor = .black
			layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
		case .incoming:
			backgroundColor = .incoming
			textLabel.textColor = .white
			layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
		}
	}
}

private extension UIColor {
	static let outgoing = UIColor(red: 0.9, green: 0.9, blue: 0.92, alpha: 1)
	static let incoming = UIColor(red: 0.15, green: 0.57, blue: 0.96, alpha: 1)
}
