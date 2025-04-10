import SwiftUI

struct ContentView: View {
    @State var isLicensesPresented: Bool = false
    @State private var timetables: [Timetable] = []
    @State private var selectedDay = 0

    var body: some View {
        DropdownSelectableTimetableView()
    }
    
    var licenseButton: some View {
        Button {
            isLicensesPresented = true
        } label: {
            Image(systemName: "list.bullet.rectangle.portrait")
        }
    }
}
