import Foundation

public class WPAuthor: Decodable {
    
    public let id: Int
    public let name: String
    
    public class func getAuthors(web: Web, completionHandler: @escaping ([WPAuthor])->()) {
        
        let url = URL(string: web.url + "/wp-json/wp/v2/users?per_page=100")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Basic \(web.token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let networkManager = NetworkManager<[WPAuthor]>(request: request)
        networkManager.get { authors, _ in
            completionHandler(authors)
        }
        
    }
    
    public class func getAuthor(web: Web, id: Int, completionHandler: @escaping (WPAuthor) -> ()) {
        
        let url = URL(string: web.url + "/wp-json/wp/v2/users/\(id)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Basic \(web.token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let networkManager = NetworkManager<WPAuthor>(request: request)
        networkManager.get { author, _ in
            completionHandler(author)
        }
    }
    
}

extension WPAuthor: Equatable {
    public static func == (lhs: WPAuthor, rhs: WPAuthor) -> Bool {
        return lhs.id == rhs.id
    }
}
