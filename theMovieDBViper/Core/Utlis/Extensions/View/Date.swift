//
//  Date.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 03/10/23.
//

import Foundation

extension Date {
    
    static func dateNow() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
    
    // Convert a Date to a string in Jakarta time zone
    func toStringInJakartaTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
        
        return dateFormatter.string(from: self)
    }
    
    // Convert a string in Jakarta time zone to a Date
    func fromStringInJakartaTime(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
        
        return dateFormatter.date(from: dateString)
    }
}




