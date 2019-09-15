import XCTest
@testable import WordPressSwift

final class FeaturedImageTests: XCTestCase {
    
    let web = WPWeb(name: "WordPress Blog", url: "https://wordpress.org/news", token: nil)
    
    func testImage() {
        var image: WPMedia? = nil
        let downloadExpectation = XCTestExpectation()
        WPMedia.getImage(web: web, id: 6926) { downloadedImage in
            image = downloadedImage
            downloadExpectation.fulfill()
        }
        wait(for: [downloadExpectation], timeout: 10)
        XCTAssertNotNil(image)
        XCTAssert(image!.id == 6926)
    }

    static var allTests = [
        ("testImage", testImage),
    ]
}
