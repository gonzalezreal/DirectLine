import Combine
import Foundation
import Logging

public struct ActivityStreamPublisher<ChannelData>: Publisher where ChannelData: Codable, ChannelData: Equatable {
    public typealias Output = ActivityGroup<ChannelData>
    public typealias Failure = Error

    public let streamURL: URL

    private let session: URLSession
    private let logLevel: Logger.Level

    public init(streamURL: URL, session: URLSession = URLSession(configuration: .default), logLevel: Logger.Level = .info) {
        self.streamURL = streamURL
        self.session = session
        self.logLevel = logLevel
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let webSocketTask = session.webSocketTask(with: streamURL)
        let subscription = ActivityStreamSubscription(subscriber: subscriber, webSocketTask: webSocketTask, logLevel: logLevel)

        subscriber.receive(subscription: subscription)
    }
}

private final class ActivityStreamSubscription<S, ChannelData>: Subscription where S: Subscriber, S.Input == ActivityGroup<ChannelData>, S.Failure == Error {
    var subscriber: S?
    let webSocketTask: URLSessionWebSocketTask
    let decoder = JSONDecoder()
    var logger = Logger(label: "ActivityStreamSubscription")
    var demand = Subscribers.Demand.none
    let lock = DispatchQueue(label: "com.gonzalezreal.DirectLine.ActivityStreamSubscription")

    var hasDemand: Bool {
        lock.sync { demand > .none }
    }

    init(subscriber: S, webSocketTask: URLSessionWebSocketTask, logLevel: Logger.Level) {
        self.subscriber = subscriber
        self.webSocketTask = webSocketTask

        logger.logLevel = logLevel
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
    }

    func cancel() {
        webSocketTask.cancel(with: .goingAway, reason: nil)
        subscriber = nil
    }

    func request(_ demand: Subscribers.Demand) {
        addDemand(demand)

        if case .suspended = webSocketTask.state, hasDemand {
            scheduleNextReceive()
            webSocketTask.resume()
        }
    }

    func scheduleNextReceive() {
        webSocketTask.receive { [weak self] result in
            guard let self = self, self.hasDemand else { return }

            switch result {
            case let .failure(error):
                self.subscriber?.receive(completion: .failure(error))
            case let .success(message):
                self.sendMessage(message)
                self.decrementDemand()
                self.scheduleNextReceive()
            }
        }
    }

    func sendMessage(_ message: URLSessionWebSocketTask.Message) {
        guard case let .string(text) = message, !text.isEmpty, let data = text.data(using: .utf8) else { return }

        logger.debug("\(logDescription(content: data.logDescription))")

        do {
            let activityGroup = try decoder.decode(ActivityGroup<ChannelData>.self, from: data)
            _ = subscriber?.receive(activityGroup)
        } catch {
            subscriber?.receive(completion: .failure(error))
        }
    }

    func addDemand(_ demand: Subscribers.Demand) {
        lock.sync { self.demand += demand }
    }

    func decrementDemand() {
        lock.sync { demand -= .max(1) }
    }

    func logDescription(content: String) -> String {
        var result = "[RECEIVE] \(webSocketTask.originalRequest?.url?.absoluteString ?? "")"
        if !content.isEmpty {
            result += "\n ├─ Content\n\(content)"
        }
        return result
    }
}

public extension Publisher {
    func activityStream<C>(_: C.Type, logLevel: Logger.Level = .info) -> AnyPublisher<ActivityGroup<C>, Error> where C: Codable, C: Equatable, Output == Conversation {
        compactMap { $0.streamURL }
            .mapError { $0 as Error }
            .flatMap { ActivityStreamPublisher(streamURL: $0, logLevel: logLevel) }
            .eraseToAnyPublisher()
    }
}
