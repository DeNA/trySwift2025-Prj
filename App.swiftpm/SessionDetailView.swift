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
            Text(session.title)
                .font(.title)
                .padding()
            
            HStack {
                Text("登壇者:").padding()
                Text(session.speakers?.first?.name ?? "なし")
                // Please add Job-Title
            }
            
            HStack {
                Text("会場:").padding()
                Text(session.place)
            }
            // TODO:概要のデータを出したいよね
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
