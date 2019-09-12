import Foundation

/**
 WPCategory represents a category that exists on a WordPress blog.
 */
public class WPCategory: Codable {
    
    public let id: Int
    public let count: Int
    public let description: String
    public let link: String
    public let name: String
    public let slug: String
    public let taxonomy: String
    public let parent: Int
    
    /// Gets all the categories from the specified website.
    /// - Parameter web: Object representing the website to use as source of categories.
    /// - Parameter completionHandler: A closure which is called with the array of categories available.
    public class func getCategories(web: Web, completionHandler: @escaping ([WPCategory])->() ) {
        
        let url = URL(string: web.url + "/wp-json/wp/v2/categories?per_page=100")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Basic \(web.token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let networkManager = NetworkManager<[WPCategory]>(request: request)
        networkManager.get { categories, _ in
            completionHandler(categories)
        }
        
    }
    
    /// Gets the information of one category identified by id.
    /// - Parameter web: Object representing the website to use as source of categories.
    /// - Parameter id: Category's ID
    /// - Parameter completionHandler: A closure which is called with the WPCategory object.
    public class func getCategory(web: Web, id: Int, completionHandler: @escaping (WPCategory) -> ()) {
        
        let url = URL(string: web.url + "/wp-json/wp/v2/categories/\(id)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Basic \(web.token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let networkManager = NetworkManager<WPCategory>(request: request)
        networkManager.get { category, _ in
            completionHandler(category)
        }
        
    }
    
}

extension WPCategory: Equatable {
    public static func == (lhs: WPCategory, rhs: WPCategory) -> Bool {
        return lhs.id == rhs.id
    }
}
