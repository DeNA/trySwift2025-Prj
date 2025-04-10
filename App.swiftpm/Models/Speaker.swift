//
//  Speaker.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/10.
//

struct Speaker: Decodable, Identifiable {
    let id: Int
    let name: String?
    let bio: String?
    let jobTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bio
        case jobTitle = "job_title"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.jobTitle = try container.decodeIfPresent(String.self, forKey: .jobTitle)
    }
}
