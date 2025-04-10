//
//  Schedule.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/09.
//

import Foundation


struct Schedule: Decodable, Identifiable {
    let id: Int
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
    
    var formattedDate: String {
        guard let date else { return "Invalid Date" }
        
        return date.formatted()
    }
    
    var hasEnded: Bool {
        guard let date else { return false }
        return Date.now > date
    }
}
