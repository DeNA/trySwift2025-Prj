import SwiftUI

struct ContentView: View {
    @State
    var isLicensesPresented: Bool = false

//    @State var day1Timetable: Timetable?
//    @State var day2Timetable: Timetable?
//    @State var day3Timetable: Timetable?
    
    @State private var timetables: [Timetable] = []
//
    @State private var selectedDay = 0

    var body: some View {
        TabView(selection: $selectedDay) {
            ForEach(Array(zip(timetables.indices, timetables)), id: \.0) { index, timetable in
                // TODO: Day1以外のタイムテーブルも表示したい
                // TODO: Display a timetable other than day1
                NavigationStack {
                    // TODO: SessionをScheduleのdateでグループ分けしたいかも
                    // TODO: Group the Session by Schedule's date
                    List {
                        ForEach(timetable.schedules) { schedule in
                            Section {
                                ForEach(schedule.sessions) { session in
                                    Text(session.title)
                                    // TODO: Sessionの詳細画面に遷移したい
                                    // TODO: Transition to the details screen of session
                                }
                                
                            } header: {
                                // TODO: format
                                Text(schedule.formattedDate)
                                
                                // TODO: セッションが始まる前・セッション中・終了済みを表示する
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
                }
            }
            
            self.timetables = timetables
        }
    }
    
//    var timetableContent: some View {
//        Section(day1Timetable?.title ?? "Nil") {
//            Text("Write Code Please !!")
//        }
//    }
    
    var licenseButton: some View {
        Button {
            isLicensesPresented = true
        } label: {
            Image(systemName: "list.bullet.rectangle.portrait")
        }
    }
}
