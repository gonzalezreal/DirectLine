@testable import DirectLine
import SimpleNetworking
import XCTest

final class EndpointTests: XCTestCase {
    func testGenerateTokenEndpoint() {
        // given
        let expectedHeaders = [
            "Authorization": "Bearer 3xpo",
            "Accept": "application/json",
        ]

        // when
        let request = URLRequest(baseURL: .directLine, endpoint: .generateToken(secret: "3xpo"))

        // then
        XCTAssertEqual("POST", request.httpMethod)
        XCTAssertEqual(Fixtures.directLineURLWithPath("tokens/generate"), request.url)
        XCTAssertEqual(expectedHeaders, request.allHTTPHeaderFields)
    }

    func testGenerateTokenWithParametersEndpoint() throws {
        // given
        let tokenParameters = TokenParameters(user: ChannelAccount(id: "some-id", name: "test"))
        let expectedHeaders = [
            "Authorization": "Bearer 3xpo",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]

        // when
        let request = URLRequest(baseURL: .directLine, endpoint: .generateToken(secret: "3xpo", tokenParameters: tokenParameters))

        // then
        XCTAssertEqual("POST", request.httpMethod)
        XCTAssertEqual(Fixtures.directLineURLWithPath("tokens/generate"), request.url)
        XCTAssertEqual(expectedHeaders, request.allHTTPHeaderFields)
        XCTAssertEqual(try JSONEncoder().encode(tokenParameters), request.httpBody)
    }

    func testRefreshTokenEndpoint() {
        // given
        let expectedHeaders = [
            "Authorization": "Bearer 3xpo",
            "Accept": "application/json",
        ]

        // when
        let request = URLRequest(baseURL: .directLine, endpoint: .refreshToken("3xpo"))

        // then
        XCTAssertEqual("POST", request.httpMethod)
        XCTAssertEqual(Fixtures.directLineURLWithPath("tokens/refresh"), request.url)
        XCTAssertEqual(expectedHeaders, request.allHTTPHeaderFields)
    }

    static var allTests = [
        ("testGenerateTokenEndpoint", testGenerateTokenEndpoint),
        ("testGenerateTokenWithParametersEndpoint", testGenerateTokenWithParametersEndpoint),
        ("testRefreshTokenEndpoint", testRefreshTokenEndpoint),
    ]
}
