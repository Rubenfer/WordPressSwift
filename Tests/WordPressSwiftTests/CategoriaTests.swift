import XCTest
@testable import WordPressSwift

final class CategoriaTests: XCTestCase {
    
    let web = WPWeb(url: "https://wordpress.org/news", token: nil)
    
    func testCategorias() {
        var categorias: [WPCategory] = []
        let downloadExpectation = XCTestExpectation()
        WPCategory.getCategories(web: web) { downloadedCategories in
            categorias = downloadedCategories
            downloadExpectation.fulfill()
        }
        wait(for: [downloadExpectation], timeout: 10)
        XCTAssertFalse(categorias.isEmpty)
        let download1Expectation = XCTestExpectation()
        var downloadedCategory: WPCategory? = nil
        WPCategory.getCategory(web: web, id: categorias.first!.id) { categoria in
            downloadedCategory = categoria
            download1Expectation.fulfill()
        }
        wait(for: [download1Expectation], timeout: 10)
        XCTAssert(downloadedCategory != nil)
        XCTAssert(downloadedCategory! == categorias.first!)
    }

    static var allTests = [
        ("testCategorias", testCategorias),
    ]
}
