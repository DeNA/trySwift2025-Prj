//
//  Schedule.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/09.
//

struct Schedule: Decodable {
    let id: Int
    let time: String
    let sessions: [Session]
}
