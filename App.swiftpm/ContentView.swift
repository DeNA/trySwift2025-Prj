import SwiftUI

struct ContentView: View {
    @State
    var isLicensesPresented: Bool = false
    
    @State
    var day1Timetable: Timetable?
    
    @State
    var day2Timetable: Timetable?
    
    @State
    var day3Timetable: Timetable?
    
    var body: some View {
        NavigationStack {
            List {
                timetableContent
                Text("Hi Y'all :)")
                Text("Uhooi !!")
                Text("Hi Y'all :)")
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
            day1Timetable = try? decoder.decode(
                Timetable.self,
                from: Data(
                    contentsOf: Bundle.main
                        .url(
                            forResource: "2025-day1",
                            withExtension: "json"
                        )!
                )
            )
        }
    }
    
    var timetableContent: some View {
        Section {
            Text("TBD")
        } header: {
            let url = Bundle.main.url(forResource: "2025-day1", withExtension: "json")!
            let data = try! Data(contentsOf: url)
            struct Timetable: Codable {
                let id: Int
                let title: String
            }
            let timetable = try! JSONDecoder().decode(Timetable.self, from: data)
            return Text(timetable.title)
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
