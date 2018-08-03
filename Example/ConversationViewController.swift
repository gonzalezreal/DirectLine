//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import RxCocoa
import RxSwift
import UIKit

class ConversationViewController: UIViewController {

	// MARK: - Outlets

	@IBOutlet private var inputBottomConstraint: NSLayoutConstraint!
	@IBOutlet private var textField: UITextField!
	@IBOutlet private var sendButton: UIButton!
	@IBOutlet private var tableView: UITableView! {
		didSet {
			tableView.register(IncomingMessageCell.self)
			tableView.register(OutgoingMessageCell.self)
			tableView.dataSource = dataSource
		}
	}

	// MARK: - Properties

	private let conversationPresenter: ConversationPresenter
	private let dataSource = ConversationDataSource()

	// MARK: - Initialization

	init(conversationPresenter: ConversationPresenter) {
		self.conversationPresenter = conversationPresenter
		super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		conversationPresenter.view = self
		conversationPresenter.didLoad()
	}
}

extension ConversationViewController: ConversationViewProtocol {
	var keyboardWillShow: Observable<KeyboardInfo> {
		return NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
			.map { KeyboardInfo($0)! }
	}

	var keyboardWillHide: Observable<KeyboardInfo> {
		return NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
			.map { KeyboardInfo($0)! }
	}

	var messageInput: Observable<String> {
		return textField.rx.text.map { $0 ?? "" }
	}

	var sendButtonClicked: Observable<Void> {
		return Observable.merge([
			sendButton.rx.tap.asObservable(),
			textField.rx.controlEvent(.editingDidEndOnExit).asObservable()
		])
	}

	var inputPosition: Binder<InputPosition> {
		return Binder(self) { viewController, inputPosition in
			UIView.animate(withDuration: inputPosition.animationDuration) {
				viewController.inputBottomConstraint.constant = CGFloat(inputPosition.value)
				viewController.view.layoutIfNeeded()
			}
		}
	}

	var sendButtonEnabled: Binder<Bool> {
		return Binder(sendButton) { sendButton, isEnabled in
			sendButton.isEnabled = isEnabled
		}
	}

	var newMessage: Binder<Message> {
		return Binder(self) { viewController, message in
			viewController.dataSource.tableView(viewController.tableView, appendMessage: message)
		}
	}

	func clearInput() {
		textField.text = nil
	}
}
