//
//  Session.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/09.
//

struct Session: Decodable {
    let id: Int
    let title: String
    let place: String
    let summary: String?
}
