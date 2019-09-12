import Foundation

public class WPCategory: Codable {
    
    public let id: Int
    public let count: Int
    public let description: String
    public let link: String
    public let name: String
    public let slug: String
    public let taxonomy: String
    public let parent: Int
    
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
