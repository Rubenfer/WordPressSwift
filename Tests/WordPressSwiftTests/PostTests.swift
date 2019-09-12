import XCTest
@testable import WordPressSwift

final class PostTests: XCTestCase {
    
    let web = Web(name: "WordPress Blog", url: "https://wordpress.org/news", token: nil)
    
    func testGetAllPosts() {
        var posts: [WPPost] = []
        let downloadAllPostsExpectation = XCTestExpectation()
        WPPost.getPosts(web: web) { downloadedPosts in
            posts = downloadedPosts
            downloadAllPostsExpectation.fulfill()
        }
        wait(for: [downloadAllPostsExpectation], timeout: 30)
        XCTAssertFalse(posts.isEmpty)
    }
    
    func testGetSomePosts() {
        var posts: [WPPost] = []
        let download2Expectation = XCTestExpectation()
        WPPost.getPosts(web: web, numberOfPosts: 2) { downloadedPosts in
            posts += downloadedPosts
            download2Expectation.fulfill()
        }
        wait(for: [download2Expectation], timeout: 5)
        let download150Expectation = XCTestExpectation()
        WPPost.getPosts(web: web, numberOfPosts: 150) { downloadedPosts in
            posts += downloadedPosts
            download150Expectation.fulfill()
        }
        wait(for: [download150Expectation], timeout: 10)
        let download100Expectation = XCTestExpectation()
        WPPost.getPosts(web: web, numberOfPosts: 100) { downloadedPosts in
            posts += downloadedPosts
            download100Expectation.fulfill()
        }
        wait(for: [download100Expectation], timeout: 5)
        XCTAssertTrue(posts.count == 252)
        XCTAssertTrue(posts.first!.countWords() > 0)
    }
    
    func testGetOnePageOf25Posts() {
        var posts: [WPPost] = []
        let downloadExpectation = XCTestExpectation()
        WPPost.getPosts(web: web, page: 1, postsPerPage: 25) { downloadedPosts in
            posts = downloadedPosts
            downloadExpectation.fulfill()
        }
        wait(for: [downloadExpectation], timeout: 5)
        XCTAssertFalse(posts.isEmpty)
        XCTAssert(posts.count == 25)
    }
    
    func testGetPost() {
        var post: WPPost? = nil
        let downloadExpectation = XCTestExpectation()
        WPPost.getPost(web: web, id: 7086) { downloadedPost in
            post = downloadedPost
            downloadExpectation.fulfill()
        }
        wait(for: [downloadExpectation], timeout: 1)
        XCTAssert(post != nil)
        XCTAssertTrue(post!.id == 7086)
    }
    
    func testDates() {
        var posts: [WPPost] = []
        let initialDate = Date(timeIntervalSinceReferenceDate: 586310400) // 01-08-2019 00:00:00
        let downloadAllPostsExpectation = XCTestExpectation()
        WPPost.getPosts(web: web, after: initialDate.toString()) { downloadedPosts in
            posts = downloadedPosts
            downloadAllPostsExpectation.fulfill()
        }
        wait(for: [downloadAllPostsExpectation], timeout: 30)
        XCTAssertFalse(posts.isEmpty)
        let firstPost = WPPost.getFirstPost(posts)
        XCTAssert(firstPost != nil)
        XCTAssert(Date.parse(firstPost!.date) > initialDate)
        let thisMonthPosts = WPPost.getPostsMonth(posts, month: Date().month(), year: Date().year())
        let thisMonthPostsAuto = WPPost.getPostsMonth(posts)
        XCTAssert(thisMonthPosts.count == thisMonthPostsAuto.count)
        XCTAssert(thisMonthPosts.first == thisMonthPostsAuto.first)
    }
    
    func testAuthorPosts() {
        var posts: [WPPost] = []
        let downloadAllPostsExpectation = XCTestExpectation()
        WPPost.getPosts(web: web, author: 13545372) { downloadedPosts in
            posts = downloadedPosts
            downloadAllPostsExpectation.fulfill()
        }
        wait(for: [downloadAllPostsExpectation], timeout: 30)
        XCTAssertFalse(posts.isEmpty)
        XCTAssert(posts.first?.author == 13545372)
    }
    
    func testPostsOfCategories() {
        var posts: [WPPost] = []
        let downloadExpectation = XCTestExpectation()
        WPPost.getPosts(web: web, categories: [3]) { downloadedPosts in
            posts = downloadedPosts
            downloadExpectation.fulfill()
        }
        wait(for: [downloadExpectation], timeout: 5)
        XCTAssertFalse(posts.isEmpty)
        XCTAssert(posts.count >= 45)
        XCTAssert(posts.first!.categories.contains(3))
        posts = []
        let download2Expectation = XCTestExpectation()
        WPPost.getPosts(web: web, categories: [3, 143]) { downloadedPosts in
            posts = downloadedPosts
            download2Expectation.fulfill()
        }
        wait(for: [download2Expectation], timeout: 5)
        XCTAssertFalse(posts.isEmpty)
        XCTAssert(posts.count >= 47)
        XCTAssert(posts.first!.categories.contains(3) || posts.first!.categories.contains(143))
    }

    static var allTests = [
        ("testGetAllPosts", testGetAllPosts),
        ("testGetSomePosts", testGetSomePosts),
        ("testGetOnePageOf25Posts", testGetOnePageOf25Posts),
        ("testPostsOfCategories", testPostsOfCategories),
        ("testGetPost", testGetPost),
        ("testDates", testDates),
        ("testAuthorPosts", testAuthorPosts),
    ]
}
