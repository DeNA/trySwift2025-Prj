//
//  DropdownSelectableTimetableView.swift
//  App
//
//  Created by Tsutomu a{yakawa on 2025/04/10.
//

import SwiftUI

struct TimetableListItem: View {
    let session: Session

    var body: some View {
        VStack(alignment: .leading) {
            Text(session.title)
                .font(.headline)
            if let speakerName = session.speakers?.first?.name {
                Text("by \(speakerName)")
                    .font(.subheadline.italic())
            }

        }
    }
}

struct TimetableList: View {
    let timetable: Timetable?

    var body: some View {
        List {
            ForEach(timetable?.schedules ?? []) { schedule in
                Section {
                    ForEach(schedule.sessions) { session in
                        NavigationLink {
                            SessionDetailView(session: session, schedule: schedule) // FIXME: イケてる引数にして
                        } label: {
                            TimetableListItem(session: session)
                            .opacity(schedule.hasEnded ? 0.5 : 1)

                        }
                    }
                } header: {
                    HStack {
                        Text(schedule.formattedDate)
                        Text(timetable?.getSessionStatus(for: schedule.id)?.description ?? "")
                    }
                }
            }
        }
    }
}

struct DropdownSelectableTimetableView: View {
    @State private var selectedDayNumber: Int = 0
    @State private var timetables: [Timetable] = []
    @State private var selectedDayTimetable: Timetable? = nil
    
    @State private var isLicenseViewPresented: Bool = false
    
    private func showLicenseView() {
        isLicenseViewPresented = true
    }
    
    var body: some View {
        NavigationStack {
            TimetableList(timetable: selectedDayTimetable)
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
                selectedDayTimetable = timetables[selectedDayNumber]
            }
            .sheet(isPresented: $isLicenseViewPresented) {
                NavigationStack {
                    LicenseListView()
                }
            }
            .onChange(of: selectedDayNumber) { newValue in
                selectedDayTimetable = timetables[newValue]
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Day \(selectedDayNumber)", selection: $selectedDayNumber) {
                        ForEach(Array(zip(timetables.indices, timetables)), id: \.0) { index, timetable in
                            Text(timetable.title)
                                .foregroundColor(Color(UIColor.systemBlue))
                                .tag(index)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: showLicenseView) {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DropdownSelectableTimetableView()
    }
}
