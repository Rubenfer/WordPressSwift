import Foundation

/**
 Web represents a WordPress blog.
 If whe API access is protected, you shoud initialize the object with a Basic Authentication token.
 */
public struct WPWeb: Codable {
    
    public init(url: String, token: String? = nil) {
        self.url = url
        self.token = token
    }
    
    public let url: String
    public let token: String?
}

extension WPWeb: Equatable {
    public static func == (lhs: WPWeb, rhs: WPWeb) -> Bool {
        return lhs.url == rhs.url
    }
}
