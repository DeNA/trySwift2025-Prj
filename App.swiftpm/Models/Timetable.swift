//
//  Timetable.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/09.
//

struct Timetable: Decodable, Identifiable {
    let id: Int
    let title: String
    let date: String
    let schedules: [Schedule]
}
