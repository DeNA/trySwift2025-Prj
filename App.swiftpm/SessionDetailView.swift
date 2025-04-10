//
//  SwiftUIView.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/10.
//

import SwiftUI

struct SessionDetailView: View {
    let session: Session
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("タイトル:").padding()
                Text(session.title)
            }
            
            HStack {
                Text("会場:").padding()
                Text(session.place)
            }
            
            if #available(iOS 17.0, *) {
                if let summary = session.summary {
                    Text("概要:").padding()
                    Text(summary)
                } else {
                    ContentUnavailableView {
                        Label("概要なし", systemImage: "exclamationmark.bubble.fill")
                    } description: {
                        Text("このセッションには概要がありません")
                    }
                }
                
            } else {
                HStack {
                    // Fallback on earlier versions
                    Text("概要:").padding()
                    if let summary = session.summary {
                        Text(summary)
                    } else {
                        Text("なし")
                    }
                    
                }
            }
            
        }
    }
}

//#Preview {
//    SwiftUIView()
//}
