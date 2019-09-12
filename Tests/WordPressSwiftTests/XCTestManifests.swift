import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PostTests.allTests),
        testCase(RedactorTests.allTests),
        testCase(CategoriaTests.allTests),
        testCase(FeaturedImageTests.allTests),
        testCase(WebTests.allTest),
        testCase(WordPressSwiftTests.allTests),
    ]
}
#endif
