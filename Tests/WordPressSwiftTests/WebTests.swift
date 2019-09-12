import XCTest
@testable import WordPressSwift

final class WebTests: XCTestCase {
    
    func testEquals() {
        let web1 = Web(name: "WordPress Blog", url: "https://wordpress.org/news", token: nil)
        let web2 = Web(name: "WordPress Blog", url: "https://example.org/news", token: nil)
        XCTAssertFalse(web1 == web2)
    }

    static var allTests = [
        ("testEquals", testEquals),
    ]
}
