import XCTest

import WordPressSwiftTests

var tests = [XCTestCaseEntry]()
tests += PostTests.allTests()
tests += RedactorTests.allTests()
test += CategoriaTests.allTests()
test += FeaturedImageTests.allTests()
tests += WebTests.allTests()
tests += WordPressSwiftTests.allTests()
XCTMain(tests)
