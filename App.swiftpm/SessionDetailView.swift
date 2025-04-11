//
//  SwiftUIView.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/10.
//

import SwiftUI

struct SessionDetailView: View {
    let session: Session
    let sessionStatus: SessionStatus?
    let schedule: Schedule
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(session.title)
                    .font(.title.bold())
                    .multilineTextAlignment(.leading)
                
                Text(sessionStatus?.description ?? "")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(
                            cornerSize: .init(width: 40, height: 40)
                        )
                        .foregroundStyle(sessionStatus?.backgroundColor ?? .black)
                    }
                
                //TODO: 開始時間のレイアウトをいい感じにしてほしい
                VStack(alignment: .leading, spacing: 16) {
                    Text(schedule.formattedDateString)
                        .font(.caption)
                    // 終了時間をいい感じに誰か実装して
                    ForEach(session.speakers ?? []) { speaker in
                        HStack {
                            profileImageView(speaker: speaker)
                            VStack(alignment: .leading) {
                                Text(speaker.name ?? "No name")
                                    .font(.headline)
                                Text(speaker.jobTitle ?? "No job")
                                    .font(.caption2)
                            }
                        }
                    }
                }
                
                // TODO: UIをきれいにしてください！！
                if let speakers = session.speakers {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(.init(speakers.compactMap(\.bio).joined(separator: "\n")))
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("会場:")
                        .font(.headline)
                    Text(session.place)
                    
                    Spacer()
                }

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
                    }
                    
                } else {
                    HStack {
                        // Fallback on earlier versions
                        Text("概要:")
                        
                        Text(session.summary ?? "なし")
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
    
    private func profileImageView(speaker: Speaker) -> some View {
        AsyncImage(url: speaker.imageURL) { image in
            image
                .resizable()
        } placeholder: {
            Color.gray
        }
        .frame(width: 60, height: 60)
        .clipShape(.circle)
    }
}



extension URL: @retroactive Identifiable {
    public var id: String { self.absoluteString }
}

//#Preview {
//    SwiftUIView()
//}
