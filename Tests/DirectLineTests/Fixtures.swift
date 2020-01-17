import DirectLine
import Foundation

enum Fixtures {
    static func directLineURLWithPath(_ path: String, query: String? = nil) -> URL {
        let url = URL.directLine.appendingPathComponent(path)

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.query = query

        return components.url!
    }
}
