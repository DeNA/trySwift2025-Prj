//
//  Speaker.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/10.
//
import Foundation

struct Speaker: Decodable, Identifiable {
    let id: Int
    let name: String?
    let bio: String?
    let jobTitle: String?
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bio
        case jobTitle = "job_title"
        case imageURL = "image_url"
    }
}
