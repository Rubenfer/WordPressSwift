//
//  WordPressSwiftTests.swift
//  WordPressSwiftTests
//
//  Created by Ruben Fernandez on 09/12/2018.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import XCTest

class WordPressSwiftTests: XCTestCase {
    
    let url = "https://wordpress.org/news/"
    
    func testGetCategories() {
        let expectation = XCTestExpectation(description: "Get categories")
        WordpressSwift.getCategories(blogURL: url) { categories in
            XCTAssertGreaterThan(categories.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testGetPosts() {
        let expectation = XCTestExpectation(description: "Get posts")
        WordpressSwift.getPosts(blogURL: url, page: 1, postPerPage: 5) { posts in
            XCTAssertGreaterThan(posts.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testGetPostFromCategory() {
        let expectation = XCTestExpectation(description: "Get posts from category")
        WordpressSwift.getPosts(blogURL: url, page: 1, postPerPage: 5, categoryID: [143]) { posts in
            XCTAssertGreaterThan(posts.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }

}
