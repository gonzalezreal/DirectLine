import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(EndpointTests.allTests),
            testCase(AnyValueTests.allTests),
            testCase(ActivityTests.allTests),
        ]
    }
#endif
