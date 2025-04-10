import SwiftUI

struct ContentView: View {
    @State var isLicensesPresented: Bool = false
    @State private var timetables: [Timetable] = []
    @State private var selectedDay = 0

    var body: some View {
        TabView(selection: $selectedDay) {
            ForEach(Array(zip(timetables.indices, timetables)), id: \.0) { index, timetable in
                NavigationStack {
                    List {
                        ForEach(timetable.schedules) { schedule in
                            Section {
                                ForEach(schedule.sessions) { session in
                                    // TODO: Show speaker name
                                    // FIXME: 20250410 13:10 のセッションが複数表示されている
                                    NavigationLink {
                                        // TODO: Sessionの詳細画面をファイル分割作る
                                        SessionDetailView(session: session)
                                    } label: {
                                        VStack(alignment: .leading) {
                                            Text(session.title)
                                                .font(.headline)
                                            if let speakerName = session.speakers?.first?.name {
                                                Text("by \(speakerName)")
                                                    .font(.subheadline.italic())
                                            }
                                            
                                        }
                                        .opacity(schedule.hasEnded ? 0.5 : 1)
                                        
                                    }
                                }
                                
                            } header: {
                                Text(schedule.formattedDate)
                                
                                // TODO: セッションのステータスを表示する（開始前・セッション中・終了済み）
                                // TODO: Render the state of the session (preparing, ongoing and finished)
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            licenseButton
                        }
                    }
                }
                .tabItem {
                    Label(timetable.title, systemImage: "\(index + 1).circle.fill")
                }
            }
        }
        .sheet(isPresented: $isLicensesPresented) {
            NavigationStack(root: {
                LicenseListView()
            })
        }
        .onAppear {
            var timetables: [Timetable] = []
            let decoder = JSONDecoder()
            
            for day in 1...3 {
                do {
                    let timetable = try decoder.decode(
                        Timetable.self,
                        from: Data(
                            contentsOf: Bundle.main.url(forResource: "2025-day\(day)", withExtension: "json")!
                        )
                    )
                    timetables.append(timetable)
                } catch {
                    //
                    print("Error: \(error)")
                }
            }
            
            self.timetables = timetables
        }
    }
    
    var licenseButton: some View {
        Button {
            isLicensesPresented = true
        } label: {
            Image(systemName: "list.bullet.rectangle.portrait")
        }
    }
}
