import Foundation

/**
 Web represents a WordPress blog.
 If whe API access is protected, you shoud initialize the object with a Basic Authentication token.
 */
public struct Web: Codable {
    public let name: String
    public let url: String
    public let token: String?
}

extension Web: Equatable {
    public static func == (lhs: Web, rhs: Web) -> Bool {
        return lhs.url == rhs.url
    }
}
