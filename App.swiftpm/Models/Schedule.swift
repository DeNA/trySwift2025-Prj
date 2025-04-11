//
//  Schedule.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/09.
//

import Foundation


struct Schedule: Decodable, Identifiable {
    let id: Int
    //TODO: JSONから取る時にDateにする
    let time: String
    let sessions: [Session]
}

extension Schedule {
    var date: Date? {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return RFC3339DateFormatter.date(from: time)
    }
    
    var formattedDateString: String {
        guard let date else { return "Invalid Date" }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return formatter.string(from: date)
    }
    
    var hasEnded: Bool {
        guard let date else { return false }
        return Date.now > date
    }
}
