import Foundation
import RxSwift

public extension URL {
	static let directLineBaseURL = URL(string: "https://directline.botframework.com/v3/directline")!
}

public final class DirectLine {
	public private(set) lazy var activities: Observable<Activity> = self
		.conversation
		.flatMapFirst { Observable.activityStream(url: $0.streamURL) }
		.flatMap { return Observable.from($0.activities) }

	private let token: String
	private let client: Client

	private lazy var conversation: Observable<Conversation> = self
		.startConversation()
		.flatMap { [weak self] conversation -> Observable<Conversation> in
			guard let `self` = self else { return Observable.empty() }
			return self.refresh(conversation: conversation)
		}
		.shareReplayLatestWhileConnected()

	public convenience init(token: String, baseURL: URL = .directLineBaseURL) {
		self.init(token: token, client: Client(baseURL: baseURL))
	}

	init(token: String, client: Client) {
		self.token = token
		self.client = client
	}

	public func post(activity: Activity) -> Observable<Resource> {
		return conversation
			.flatMapLatest { self.post(activity: activity, to: $0) }
	}
}

private extension DirectLine {
	func startConversation() -> Observable<Conversation> {
		return client.request(Conversation.self, from: .startConversation(token: token))
	}

	func refresh(conversation: Conversation) -> Observable<Conversation> {
		return client.request(Token.self, from: .refresh(token: conversation.token.value))
			.delaySubscription(conversation.token.refreshInterval, scheduler: MainScheduler.instance)
			.flatMap { [weak self] token -> Observable<Conversation> in
				guard let `self` = self else { return Observable.empty() }

				var newConversation = conversation
				newConversation.token = token

				return Observable.concat([
					Observable.just(newConversation),
					self.refresh(conversation: newConversation)
				])
			}
	}

	func post(activity: Activity, to conversation: Conversation) -> Observable<Resource> {
		return client.request(
			Resource.self,
			from: .post(
				activity: activity,
				conversationId: conversation.conversationId,
				token: conversation.token.value
			)
		)
	}
}

private extension Token {
	var refreshInterval: TimeInterval {
		return expiresIn / 2
	}
}
