import Foundation

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
