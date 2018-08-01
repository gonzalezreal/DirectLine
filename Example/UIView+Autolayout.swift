//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import UIKit

extension UIView {
	func constraintsForEdges(to view: UIView, inset: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
		return [
			topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
			leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
			bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset.bottom),
			trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset.right)
		]
	}

	func addSubview(_ subview: UIView, constraints: [NSLayoutConstraint]) {
		subview.translatesAutoresizingMaskIntoConstraints = false
		addSubview(subview)
		NSLayoutConstraint.activate(constraints)
	}
}
