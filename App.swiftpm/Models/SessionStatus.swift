//
//  SessionStatus.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/11.
//

import SwiftUI

enum SessionStatus {
    case preparing
    case ongoing
    case finished
}

extension SessionStatus {
    var description: String {
        switch self {
        case .preparing:
            "準備中"
        case .ongoing:
            "進行中"
        case .finished:
            "終了"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .finished:
                .accentColor
        case .ongoing:
                .mint
        case .preparing:
                .orange
        }
    }
}
