//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import DirectLine
import Foundation
import RxCocoa
import RxSwift

protocol ConversationViewProtocol: class {
	var keyboardWillShow: Observable<KeyboardInfo> { get }
	var keyboardWillHide: Observable<KeyboardInfo> { get }
	var messageInput: Observable<String> { get }
	var sendButtonClicked: Observable<Void> { get }

	var inputPosition: Binder<InputPosition> { get }
	var sendButtonEnabled: Binder<Bool> { get }
	var newMessage: Binder<Message> { get }

	func clearInput()
}

final class ConversationPresenter {
	weak var view: ConversationViewProtocol?

	private let directLine: DirectLine<NoChannelData>
	private let disposeBag = DisposeBag()

	init(directLine: DirectLine<NoChannelData>) {
		self.directLine = directLine
	}

	func didLoad() {
		bindView()
	}
}

private extension ConversationPresenter {
	enum Constants {
		static let inputBottom = 8
	}

	func bindView() {
		guard let view = self.view else {
			fatalError("View not set")
		}

		view.keyboardWillShow
			.map { InputPosition(value: $0.frameHeight + Constants.inputBottom, animationDuration: $0.animationDuration) }
			.bind(to: view.inputPosition)
			.disposed(by: disposeBag)

		view.keyboardWillHide
			.map { InputPosition(value: Constants.inputBottom, animationDuration: $0.animationDuration) }
			.bind(to: view.inputPosition)
			.disposed(by: disposeBag)

		view.messageInput
			.map { !$0.isEmpty }
			.bind(to: view.sendButtonEnabled)
			.disposed(by: disposeBag)

		view.sendButtonClicked
			.do(onNext: { [view] in view.clearInput() })
			.withLatestFrom(view.messageInput)
			.map { Activity.message(from: AppConstants.userAccount, text: $0) }
			.flatMap { [directLine] in directLine.send(activity: $0) }
			.subscribe()
			.disposed(by: disposeBag)

		directLine.activities
			.map { Message(userAccount: AppConstants.userAccount, activity: $0) }
			.observeOn(MainScheduler.instance)
			.bind(to: view.newMessage)
			.disposed(by: disposeBag)
	}
}

private extension Message {
	init<ChannelData: Codable>(userAccount: ChannelAccount, activity: Activity<ChannelData>) {
		direction = activity.from == userAccount ? .outgoing : .incoming
		text = activity.text ?? "Empty"
	}
}
