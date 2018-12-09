//
//  WordpressSwift.swift
//  Wordpress Swift
//
//  Created by Ruben Fernandez on 4/3/18.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

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
