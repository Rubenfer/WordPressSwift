//
//  WordpressSwift.swift
//  Wordpress Swift
//
//  Created by Ruben Fernandez on 4/3/18.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

public struct WPPost: Codable {
    
    public struct Title: Codable {
        public let text: String
        private enum CodingKeys: String, CodingKey {
            case text = "rendered"
        }
    }
    
    public struct Content: Codable {
        public let text: String
        public let protected: Bool
        private enum CodingKeys: String, CodingKey {
            case text = "rendered"
            case protected
        }
    }
    
    public struct Excerpt: Codable {
        public let text: String
        public let protected: Bool
        private enum CodingKeys: String, CodingKey {
            case text = "rendered"
            case protected
        }
    }
    
    public let id: Int
    public let date: String
    public let date_gmt: String
    public let modified: String
    public let modified_gmt: String
    public let slug: String
    public let status: String
    public let type: String
    public let link: String
    public let title: Title
    public let content: Content
    public let excerpt: Excerpt
    public let author: Int
    public let featured_media: Int
    public let comment_status: String
    public let ping_status: String
    public let sticky: Bool
    public let template: String
    public let format: String
    public let categories: [Int]
    public let tags: [Int]
    
}

public struct WPCategory: Codable {
    
    public let id: Int
    public let count: Int
    public let description: String
    public let link: String
    public let name: String
    public let slug: String
    public let taxonomy: String
    public let parent: Int
    
}

public struct WPFeaturedImage: Codable {
    
    public struct MediaDetails: Codable {
        public let width: Int
        public let height: Int
        public let file: String
    }
    
    public let id: Int
    public let image: String
    public let type: String
    public let media_type: String
    public let media_details: MediaDetails
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case image = "source_url"
        case type
        case media_type
        case media_details
        
    }
    
    
}

public class WordpressSwift {
    
    private init() {}
    
    /// Get categories of a Wordpress site
    ///
    /// - Parameters:
    ///   - blogURL: URL of the Wordpress blog. Like: https://myblog.com
    ///   - completionHandler: The completion handler to call when the load request is complete. This completion handler takes an array of WPCategory as parameter.
    public static func getCategories(blogURL: String, completionHandler: @escaping ([WPCategory]) -> Void) {
        var categories: [WPCategory] = []
        let baseURL = blogURL + "/wp-json/wp/v2/categories"
        guard let url = URL(string: baseURL) else {
            print("ERROR: Please, type a correct URL, like:  https://myblog.com")
            completionHandler(categories)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                categories = try JSONDecoder().decode([WPCategory].self, from: data)
                DispatchQueue.main.async {
                    completionHandler(categories)
                }
            } catch {
                completionHandler(categories)
            }
            }.resume()
    }
    
    
    /// Get posts published on a Wordpress blog
    ///
    /// - Parameters:
    ///   - blogURL: URL of the Wordpress blog. Like: https://myblog.com
    ///   - page: Number of page. Use it to load content step by step. **Must be 1 or higher**
    ///   - postPerPage: Number of posts for each page. **Must be 1 or higher**
    ///   - categoryID: Array of category IDs. Use it to filter by category.
    ///   - completionHandler: The completion handler to call when the load request is complete. This completion handler takes an array of WPPost as parameter.
    public static func getPosts(blogURL: String, page: Int, postPerPage: Int, categoryID: [Int] = [], completionHandler: @escaping ([WPPost]) -> Void) {
        var posts: [WPPost] = []
        if postPerPage > 0 && page > 0 && blogURL.isEmpty == false{
            var baseURL = blogURL + "/wp-json/wp/v2/posts?page=\(page)&per_page=\(postPerPage)"
            if !categoryID.isEmpty {
                var categories = "\(categoryID.first!)"
                if categoryID.count > 1 {
                    for i in 1...categoryID.count-1 {
                        categories += ",\(categoryID[i])"
                    }
                }
                baseURL += "&categories=\(categories)"
            }
            guard let url = URL(string: baseURL) else {
                print("ERROR: Please, type a correct URL, like:  https://myblog.com")
                completionHandler(posts)
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    posts = try JSONDecoder().decode([WPPost].self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(posts)
                    }
                } catch {
                    completionHandler(posts)
                }
                }.resume()
        } else {
            print("Please, complete all parameters with correct values")
            completionHandler(posts)
        }
    }
    
    
    /// Get the featured image of a Wordpress post
    ///
    /// - Parameters:
    ///   - blogURL: URL of the Wordpress blog. Like: https://myblog.com
    ///   - post: Post to get featured image
    ///   - completionHandler: The completion handler to call when the load request is complete. This completion handler takes a WPFeaturedImage as parameter.
    public static func featuredImage(blogURL: String, post: WPPost, completionHandler: @escaping (WPFeaturedImage?) -> Void) {
        let baseURL = blogURL + "/wp-json/wp/v2/media/" + "\(post.featured_media)"
        guard let url = URL(string: baseURL) else {
            print("ERROR: Please, type a correct URL, like:  http://myblog.com")
            completionHandler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let image = try JSONDecoder().decode(WPFeaturedImage.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(image)
                }
            } catch {
                completionHandler(nil)
            }
            }.resume()
    }
    
}
