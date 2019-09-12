import Foundation

extension Date {
    
    static func parse(_ string: String) -> Date {
        let fecha = string.replacingOccurrences(of:"T", with: " ", options: .regularExpression)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: fecha) ?? ISO8601DateFormatter().date(from: string)!
    }
    
    static func monthName(_ monthNumber: Int) -> String {
        return DateFormatter().monthSymbols[monthNumber-1]
    }
    
    func day() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func month() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func year() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    func toString() -> String {
        return ISO8601DateFormatter().string(from: self)
    }
    
}
