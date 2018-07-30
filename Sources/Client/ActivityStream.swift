//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import RxSwift

internal protocol ActivityStream {
	associatedtype ChannelData: Codable

	func activityList(with url: URL) -> Observable<ActivityList<ChannelData>>
}
