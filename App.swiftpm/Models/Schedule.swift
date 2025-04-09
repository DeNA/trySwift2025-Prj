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
    var formattedDate: String {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        guard let date = RFC3339DateFormatter.date(from: time) else { return "Invalid Date" }
        
        return date.formatted()
    }
}
