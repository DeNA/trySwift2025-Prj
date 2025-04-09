import SwiftUI

struct ContentView: View {
    @State
    var isLicensesPresented: Bool = false

    @State var day1Timetable: Timetable?
    @State var day2Timetable: Timetable?
    @State var day3Timetable: Timetable?

    var body: some View {
        NavigationStack {
            List {
                if let day1Timetable {
                    ForEach(day1Timetable.schedules) { schedule in
                        ForEach(schedule.sessions) { session in
                            Text(session.title)
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    licenseButton
                }
            }
        }
        .sheet(isPresented: $isLicensesPresented) {
            NavigationStack(root: {
                LicenseListView()
            })
        }
        .onAppear {
            let decoder = JSONDecoder()
            day1Timetable = try! decoder.decode(
                Timetable.self,
                from: Data(
                    contentsOf: Bundle.main.url(forResource: "2025-day1", withExtension: "json")!
                )
            )
        }
    }
    
    var timetableContent: some View {
        Section(day1Timetable?.title ?? "Nil") {
            Text("Write Code Please !!")
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
