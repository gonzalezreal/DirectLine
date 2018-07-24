//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation
import RxSwift

internal extension ObservableType where E == Data {
	func map<R>(to type: R.Type, using decoder: JSONDecoder) -> Observable<R> where R: Decodable {
		return map {
			try decoder.decode(R.self, from: $0)
		}
	}
}
