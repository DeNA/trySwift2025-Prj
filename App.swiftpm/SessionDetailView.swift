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
                    .font(.title.bold())
                    .padding()
                    .multilineTextAlignment(.leading)

                VStack(alignment: .leading, spacing: 4) {
                    // TODO: Speakerのアイコン画像を出して欲しい
                    if let speakers = session.speakers {
                        Text(speakers.compactMap(\.imageURL).map(\.absoluteString).joined(separator: ","))
                        // TODO: いい感じに画像調節してください
                        ForEach(speakers.compactMap(\.imageURL)) { url in
                            AsyncImage(url: url)
                                .frame(maxWidth: 300)
                        }
                        Text(speakers.compactMap(\.name).joined(separator: ", ") ?? "なし")
                                .font(.title2.bold())
                        Text(speakers.compactMap(\.jobTitle).joined(separator: ", "))
                    }
                }
                .padding(8)
                
                // TODO: UIをきれいにしてください！！
                if let speakers = session.speakers {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(speakers.compactMap(\.bio).joined(separator: "\n"))
                    }
                    .padding(8)
                }
                
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("会場:")
                        .font(.headline)
                    Text(session.place)
                    
                    Spacer()
                }
                .padding(8)
                if #available(iOS 17.0, *) {
                    Group {
                        if let summary = session.summary {
                            Text("概要:")
                                .font(.headline)
                            Text(summary)
                        } else if let description = session.description {
                            Text("概要:")
                                .font(.headline)
                            Text(description)
                        } else {
                            ContentUnavailableView {
                                Label("概要なし", systemImage: "exclamationmark.bubble.fill")
                            } description: {
                                Text("このセッションには概要がありません")
                            }
                        }
                    }.padding(.horizontal, 8)
                    
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

extension URL: @retroactive Identifiable {
    public var id: String { self.absoluteString }
}

//#Preview {
//    SwiftUIView()
//}
