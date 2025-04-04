import SwiftUI

struct ContentView: View {
    @State
    var isLicensesPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                timetableContent
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
