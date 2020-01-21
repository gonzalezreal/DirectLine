import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(EndpointTests.allTests),
            testCase(AnyValueTests.allTests),
            testCase(ActivityTests.allTests),
            testCase(ActivityTypeTests.allTests),
            testCase(AttachmentTests.allTests),
            testCase(ContentAttachmentTests.allTests),
        ]
    }
#endif
