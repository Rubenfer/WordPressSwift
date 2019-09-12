import Foundation

extension Date {
    
    /// Parses a "yyyy-MM-dd HH:mm:ss" string or ISO8601 string to Date object.
    public static func parse(_ string: String) -> Date {
        let fecha = string.replacingOccurrences(of:"T", with: " ", options: .regularExpression)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: fecha) ?? ISO8601DateFormatter().date(from: string)!
    }
    
    /// Returns the name of the month specified.
    public static func monthName(_ monthNumber: Int) -> String {
        return DateFormatter().monthSymbols[monthNumber-1]
    }
    
    /// Returns the current day.
    public func day() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// Returns the current month.
    public func month() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    /// Returns the current year.
    public func year() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    /// Returns the ISO8601 string
    public func toString() -> String {
        return ISO8601DateFormatter().string(from: self)
    }
    
}
