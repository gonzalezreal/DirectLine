//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import UIKit

class ConversationViewController: UITableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(IncomingMessageCell.self)
		tableView.register(OutgoingMessageCell.self)

		tableView.separatorStyle = .none
		tableView.allowsSelection = false

		tableView.reloadData()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		fatalError("TODO: implement")
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		fatalError("TODO: implement")
	}
}
