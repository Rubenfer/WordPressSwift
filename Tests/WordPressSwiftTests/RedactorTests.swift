import XCTest
@testable import WordPressSwift

final class RedactorTests: XCTestCase {
    
    let web = WPWeb(name: "WordPress Blog", url: "https://wordpress.org/news", token: nil)
    
    func testRedactores() {
        var redactores: [WPAuthor] = []
        let downloadExpectation = XCTestExpectation()
        WPAuthor.getAuthors(web: web) { downloadedAuthors in
            redactores = downloadedAuthors
            downloadExpectation.fulfill()
        }
        wait(for: [downloadExpectation], timeout: 10)
        XCTAssertFalse(redactores.isEmpty)
        let download1Expectation = XCTestExpectation()
        var downloadedAuthor: WPAuthor? = nil
        WPAuthor.getAuthor(web: web, id: redactores.first!.id) { redactor in
            downloadedAuthor = redactor
            download1Expectation.fulfill()
        }
        wait(for: [download1Expectation], timeout: 10)
        XCTAssert(downloadedAuthor != nil)
        XCTAssert(downloadedAuthor! == redactores.first!)
    }

    static var allTests = [
        ("testRedactores", testRedactores),
    ]
}
