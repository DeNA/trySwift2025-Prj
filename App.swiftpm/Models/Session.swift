//
//  Session.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/09.
//

struct Session: Decodable, Identifiable {
    let id: Int
    let title: String
    let place: String
    let summary: String?
    let description: String?
    let speakers: [Speaker]?
}
