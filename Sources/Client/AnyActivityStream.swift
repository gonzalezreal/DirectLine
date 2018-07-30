//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import RxSwift

internal final class AnyActivityStream<ChannelData: Codable>: ActivityStream {
	private let _activityList: (URL) -> Observable<ActivityList<ChannelData>>

	init<A: ActivityStream>(_ activityStream: A) where A.ChannelData == ChannelData {
		_activityList = activityStream.activityList
	}

	func activityList(with url: URL) -> Observable<ActivityList<ChannelData>> {
		return _activityList(url)
	}
}
