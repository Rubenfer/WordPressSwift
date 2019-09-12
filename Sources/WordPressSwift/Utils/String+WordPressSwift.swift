import Foundation

extension String {
    
    internal func clean() -> String {
        // Remove URLs
        var str = self.replacingOccurrences(of: "@(https?://([-\\w\\.]+[-\\w])+(:\\d+)?(/([\\w/_\\.#-]*(\\?\\S+)?[^\\.\\s])?)?)@", with: "", options: .regularExpression, range: self.startIndex ..< self.endIndex)
        // Remove HTML
        str = str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: str.startIndex ..< str.endIndex)
        return str
    }
    
}
