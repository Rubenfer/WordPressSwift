import Foundation

public class WPMedia: Codable {
    
    public struct MediaDetails: Codable {
        public let width: Int
        public let height: Int
        public let file: String
    }
    
    public let id: Int
    public let source_url: String
    public let type: String
    public let media_type: String
    public let media_details: MediaDetails
    
    public class func getImage(web: Web, id: Int, completionHandler: @escaping (WPMedia)->()) {
        
        let urlStr = web.url + "/wp-json/wp/v2/media/\(id)"
        
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        request.setValue("Basic \(web.token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let networkManager = NetworkManager<WPMedia>(request: request)
        networkManager.get { image, _ in
            completionHandler(image)
        }
        
    }
    
}
