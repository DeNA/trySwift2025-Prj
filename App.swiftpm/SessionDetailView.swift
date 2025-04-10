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
        ScrollView {
            VStack(alignment: .leading) {
                Text(session.title)
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("登壇者:").padding()
                    Text(session.speakers?.compactMap(\.name).joined(separator: ", ") ?? "なし")
                    Spacer()
                }
                
                // TODO: UIをきれいにしてください！！
                if let speakers = session.speakers {
                    HStack {
                        Text("登壇者の概要:")
                        
                        Text(speakers.compactMap(\.bio).joined(separator: "\n"))
                    }
                }
                
                if let speakers = session.speakers {
                    HStack(spacing: 8) {
                        Text("職業")
                        Text(speakers.compactMap(\.jobTitle).joined(separator: ", "))
                    }
                }
                
                HStack {
                    Text("会場:").padding()
                    Text(session.place)
                    
                    Spacer()
                }
                if #available(iOS 17.0, *) {
                    if let summary = session.summary {
                        Text("概要:").padding()
                        Text(summary)
                            .padding(.horizontal, 16.0)
                    } else if let description = session.description {
                        Text("概要:").padding()
                        Text(description)
                            .padding(.horizontal, 16.0)
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
                                .padding(.horizontal, 16.0)
                        } else {
                            Text("なし")
                        }
                        
                    }
                }
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    SwiftUIView()
//}
