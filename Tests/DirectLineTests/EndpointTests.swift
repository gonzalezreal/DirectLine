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

    func testStartConversationEndpoint() {
        // given
        let expectedHeaders = [
            "Authorization": "Bearer 3xpo",
            "Accept": "application/json",
        ]

        // when
        let request = URLRequest(baseURL: .directLine, endpoint: .startConversation(.token("3xpo")))

        // then
        XCTAssertEqual("POST", request.httpMethod)
        XCTAssertEqual(Fixtures.directLineURLWithPath("conversations"), request.url)
        XCTAssertEqual(expectedHeaders, request.allHTTPHeaderFields)
    }

    func testStartConversationEndpointWithParameters() {
        // given
        let tokenParameters = TokenParameters(user: ChannelAccount(id: "some-id", name: "test"))
        let expectedHeaders = [
            "Authorization": "Bearer 3xpo",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]

        // when
        let request = URLRequest(baseURL: .directLine, endpoint: .startConversation(secret: "3xpo", tokenParameters: tokenParameters))

        // then
        XCTAssertEqual("POST", request.httpMethod)
        XCTAssertEqual(Fixtures.directLineURLWithPath("conversations"), request.url)
        XCTAssertEqual(expectedHeaders, request.allHTTPHeaderFields)
        XCTAssertEqual(try JSONEncoder().encode(tokenParameters), request.httpBody)
    }

    func testConversationEndpoint() {
        // given
        let expectedHeaders = [
            "Authorization": "Bearer 3xpo",
            "Accept": "application/json",
        ]

        // when
        let request = URLRequest(baseURL: .directLine, endpoint: .conversation(.secret("3xpo"), conversationId: "any-conversation"))

        // then
        XCTAssertEqual("GET", request.httpMethod)
        XCTAssertEqual(Fixtures.directLineURLWithPath("conversations/any-conversation"), request.url)
        XCTAssertEqual(expectedHeaders, request.allHTTPHeaderFields)
    }

    func testConversationEndpointWithWatermark() {
        // given
        let expectedHeaders = [
            "Authorization": "Bearer 3xpo",
            "Accept": "application/json",
        ]

        // when
        let request = URLRequest(baseURL: .directLine, endpoint: .conversation(.secret("3xpo"), conversationId: "any-conversation", watermark: "any-watermark"))

        // then
        XCTAssertEqual("GET", request.httpMethod)
        XCTAssertEqual(Fixtures.directLineURLWithPath("conversations/any-conversation", query: "watermark=any-watermark"), request.url)
        XCTAssertEqual(expectedHeaders, request.allHTTPHeaderFields)
    }

    static var allTests = [
        ("testGenerateTokenEndpoint", testGenerateTokenEndpoint),
        ("testGenerateTokenWithParametersEndpoint", testGenerateTokenWithParametersEndpoint),
        ("testRefreshTokenEndpoint", testRefreshTokenEndpoint),
        ("testStartConversationEndpoint", testStartConversationEndpoint),
        ("testStartConversationEndpointWithParameters", testStartConversationEndpointWithParameters),
        ("testConversationEndpoint", testConversationEndpoint),
        ("testConversationEndpointWithWatermark", testConversationEndpointWithWatermark),
    ]
}
