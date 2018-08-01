//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import UIKit

protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
	static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}

extension UITableView {
	func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
		register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}

	func dequeueReusableCell<T: UITableViewCell>(_: T.Type) -> T where T: ReusableView {
		guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}

		return cell
	}

	func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
		guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}

		return cell
	}

	func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for row: Int) -> T where T: ReusableView {
		return dequeueReusableCell(T.self, for: IndexPath(row: row, section: 0))
	}
}
