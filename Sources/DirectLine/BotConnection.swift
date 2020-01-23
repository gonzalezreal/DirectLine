import Combine
import Foundation
import Logging
import SimpleNetworking

public class BotConnection<ChannelData> {
    public var state: AnyPublisher<BotConnectionState, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    public var activities: AnyPublisher<Activity<ChannelData>, Never> {
        activitiesSubject.eraseToAnyPublisher()
    }

    private let apiClient = APIClient(baseURL: .directLine)
    private let stateSubject = CurrentValueSubject<BotConnectionState, Never>(.uninitialized)
    private let activitiesSubject = PassthroughSubject<Activity<ChannelData>, Never>()
    
    private let secret: String
    private var logger = Logger(label: "BotConnection")

    public init(secret: String, logLevel: Logger.Level) {
        self.secret = secret
        
        // TODO: add the logLevel as a construction parameter in APIClient
        apiClient.logger.logLevel = logLevel
        logger.logLevel = logLevel
    }

    public func postActivity(_: Activity<ChannelData>) -> AnyPublisher<ResourceResponse, Error> {
        fatalError("TODO: implement")
    }
}
