import Foundation

/**
 WPPost represents a created post.
 */
public class WPPost: Decodable {
    
    public struct Content: Codable {
        public let rendered: String
        public let protected: Bool
    }
    
    public struct Title: Codable {
        public let rendered: String
    }
    
    public struct Excerpt: Codable {
        public let rendered: String
        public let protected: Bool
    }
    
    public let id: Int
    public let date: String
    public let modified: String
    public let slug: String
    public let status: String
    public let type: String
    public let link: String
    public let title: Title
    public let content: Content
    public let excerpt: Excerpt
    public let author: Int
    public let featured_media: Int
    public let categories: [Int]
    public let tags: [Int]
    
    /// Calculates the lenght of the post.
    public func countWords() -> Int {
        let components = content.rendered.clean().components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        return words.count
    }
    
    /// Gets the posts of a specified website.
    /// - Parameter web: Object representing the website to use as source of posts.
    /// - Parameter author: (Optional) Get only the posts of a concrete author identified by id. By default returns posts of all authors.
    /// - Parameter numberOfPosts: (Optional) Get only the 'numberOfPosts' latests posts. By defaults returns all posts.
    /// - Parameter date: (Optional) Get only the posts created since 'date'. ISO8601 string (you can generate it using `toString()`Date method available when you import WordPressSwift). By default returns all posts.
    /// - Parameter categories: (Optional) Get only the posts associated with the specified categories. By default returns all posts.
    /// - Parameter completionHandler: A closure which is called with the array of posts.
    public class func getPosts(web: WPWeb, author: Int = 0, numberOfPosts: Int = 0, after date: String? = nil, categories: [Int] = [], completionHandler: @escaping ([WPPost])->()) {
        
        var posts: [WPPost] = []
        
        if numberOfPosts == 0 {
            var totalPosts = -1
            var i = 1
            DispatchQueue(label: "getAllPosts").async {
                repeat {
                    let dispatchGroup = DispatchGroup()
                    dispatchGroup.enter()
                    getPosts(web: web, page: i, postPerPage: 100, author: author, after: date, categories: categories) { downloadedPosts, response in
                        totalPosts = Int(response.allHeaderFields[AnyHashable("x-wp-total")] as! String)!
                        posts += downloadedPosts
                        dispatchGroup.leave()
                    }
                    i+=1
                    dispatchGroup.wait()
                } while posts.count < totalPosts
                completionHandler(posts)
            }
        } else {
            DispatchQueue(label: "getPosts").async {
                let dispatchGroup = DispatchGroup()
                for i in 1...(numberOfPosts % 100 == 0 ? numberOfPosts/100 : numberOfPosts/100+1) {
                    dispatchGroup.enter()
                    getPosts(web: web, page: i, postPerPage: numberOfPosts - posts.count < 100 ? numberOfPosts - posts.count : 100, author: author, after: date, categories: categories) { downloadedPosts, _ in
                        posts += downloadedPosts
                        dispatchGroup.leave()
                    }
                    dispatchGroup.wait()
                }
                completionHandler(posts)
            }
        }
        
    }
    
    /// Gets the posts of a specified website.
    /// - Parameter web: Object representing the website to use as source of posts.
    /// - Parameter page: The number of the page to download.
    /// - Parameter postsPerPage: The number of posts per downloaded page.
    /// - Parameter author: (Optional) Get only the posts of a concrete author identified by id. By default returns posts of all authors.
    /// - Parameter date: (Optional) Get only the posts created since 'date'. ISO8601 string (you can generate it using `toString()`Date method available when you import WordPressSwift). By default returns all posts.
    /// - Parameter categories: (Optional) Get only the posts associated with the specified categories. By default returns all posts.
    /// - Parameter completionHandler: A closure which is called with the array of posts.
    public class func getPosts(web: WPWeb, page: Int, postsPerPage: Int, author: Int = 0, after date: String? = nil, categories: [Int] = [], completionHandler: @escaping ([WPPost])->()) {
        getPosts(web: web, page: page, postPerPage: postsPerPage, author: author, after: date, categories: categories) { posts, _ in
            completionHandler(posts)
        }
    }
    
    private class func getPosts(web: WPWeb, page: Int, postPerPage: Int, author: Int = 0, after date: String? = nil, categories: [Int] = [], completionHandler: @escaping ([WPPost], HTTPURLResponse)->()) {
        
        var baseUrlStr = web.url + "/wp-json/wp/v2/posts?"
        
        if author != 0 {
            baseUrlStr += "author=\(author)&"
        }
        
        if let date = date {
            baseUrlStr += "after=\(date)&"
        }
        
        if !categories.isEmpty {
            var categoriesStr = ""
            categories.forEach { category in
                categoriesStr += "\(category),"
            }
            categoriesStr.removeLast()
            baseUrlStr += "categories=\(categoriesStr)&"
        }
        
        var request = URLRequest(url: URL(string: baseUrlStr + "per_page=\(postPerPage)&page=\(page)")!)
        request.httpMethod = "GET"
        request.setValue("Basic \(web.token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let networkManager = NetworkManager<[WPPost]>(request: request)
        networkManager.get { posts, response in
            completionHandler(posts, response)
        }
        
    }
    
    /// Get a concrete post.
    /// - Parameter web: Object representing the website to use as source of posts.
    /// - Parameter id: Post's id.
    /// - Parameter completionHandler: A closure which is called with the WPPost.
    public class func getPost(web: WPWeb, id: Int, completionHandler: @escaping (WPPost)->()) {
        
        let urlStr = web.url + "/wp-json/wp/v2/posts/\(id)"
        
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        request.setValue("Basic \(web.token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let networkManager = NetworkManager<WPPost>(request: request)
        networkManager.get { post, _ in
            completionHandler(post)
        }
        
    }
    
    /// Filters an array of WPPost to search the posts created at concrete month.
    /// - Parameter allPosts: Array of posts to use as source of data.
    /// - Parameter month: Month number.
    /// - Parameter year: Year number.
    public class func getPostsMonth(_ allPosts: [WPPost], month: Int, year: Int) -> [WPPost] {
        return allPosts.filter( { Date.parse($0.date).year() == year && Date.parse($0.date).month() == month } )
    }
    
    /// Filters an array of WPPost to search the posts created at current month.
    /// - Parameter allPosts: Array of posts to use as source of data.
    public class func getPostsMonth(_ allPosts: [WPPost]) -> [WPPost] {
        let currentDate = Date()
        return getPostsMonth(allPosts, month: currentDate.month(), year: currentDate.year())
    }
    
    /// Returns the first post created.
    /// - Parameter allPosts: Array of posts to use as source of data.
    public class func getFirstPost(_ allPosts: [WPPost]) -> WPPost? {
        return allPosts.sorted(by: { Date.parse($0.date) < Date.parse($1.date) } ).first
    }
    
}

extension WPPost: Equatable {
    public static func == (lhs: WPPost, rhs: WPPost) -> Bool {
        return lhs.id == rhs.id
    }
}
