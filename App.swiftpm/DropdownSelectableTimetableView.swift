//
//  DropdownSelectableTimetableView.swift
//  App
//
//  Created by Tsutomu a{yakawa on 2025/04/10.
//

import SwiftUI

struct TimetableListItemView: View {
    let session: Session
    
    var body: some View {
        HStack{
            if let speakers = session.speakers {
                ForEach(speakers) { speaker in
                    AsyncImage(url: speaker.imageURL){ image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }.frame(width: 60, height: 60)
                        .clipShape(.circle)
                }
            }
            VStack(alignment: .leading) {
                Text(session.title)
                    .font(.headline)
                if let speakers = session.speakers {
                    ForEach(speakers) { speaker in
                        if let speakerName = speaker.name {
                            Text("by \(speakerName)")
                                .font(.subheadline.italic())
                        }
                    }
                }
                
            }
        }
    }
}

struct TimetableListView: View {
    let timetable: Timetable?
    
    var body: some View {
        List {
            ForEach(timetable?.schedules ?? []) { schedule in
                Section {
                    ForEach(schedule.sessions) { session in
                        NavigationLink {
                            SessionDetailView(
                                session: session,
                                sessionStatus: timetable?.getSessionStatus(for: schedule.id),
                                schedule: schedule
                            ) // FIXME: イケてる引数にして
                        } label: {
                            TimetableListItemView(session: session)
                                .opacity(schedule.hasEnded ? 0.5 : 1)
                            
                        }
                    }
                } header: {
                    HStack {
                        Text(schedule.formattedDateString)
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
            
            TimetableListView(timetable: selectedDayTimetable)
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
                        InfoView()
                    }
                }
                .onChange(of: selectedDayNumber) { newValue in
                    selectedDayTimetable = timetables[newValue]
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 8)
                            .frame(width: 180)
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        ZStack {
                            HStack {
                                Text("")
                                    .foregroundColor(.accentColor)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundColor(.accentColor)
                            }
                            .padding(.trailing, -12)
                            
                            HStack {
                                Picker(
                                    "",
                                    selection: $selectedDayNumber
                                ) {
                                    ForEach(Array(zip(timetables.indices, timetables)), id: \.0) { index, timetable in
                                        Text(timetable.title)
                                            .foregroundColor(Color(UIColor.systemBlue))
                                            .tag(index)
                                    }
                                }
                                .pickerStyle(.menu)
                                .foregroundStyle(.clear)
                            }
                        }
//                        ZStack {
//                            HStack {
//                                Text("Day \(selectedDayNumber)")
//                                    .foregroundColor(.accentColor)
//                                
//                                Image(systemName: "chevron.up.chevron.down")
//                                    .foregroundColor(.accentColor)
//                            }
//                            
//                            HStack {
//                                Picker(
//                                    "",
//                                    selection: $selectedDayNumber
//                                ) {
//                                    ForEach(Array(zip(timetables.indices, timetables)), id: \.0) { index, timetable in
//                                        Text(timetable.title)
//                                            .foregroundColor(Color(UIColor.systemBlue))
//                                            .tag(index)
//                                    }
//                                }
//                                .pickerStyle(.menu)
//                                .foregroundStyle(.clear)
//                            }
//                        }

//                        HStack {
//                            Text("Day \(selectedDayNumber)")
//                                .foregroundColor(.accentColor)
//                            
//                            Spacer()
//                            
//                            Image(systemName: "chevron.up.chevron.down")
//                                .foregroundColor(.accentColor)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .overlay {
//                            Picker(
//                                selection: $selectedDayNumber,
//                                label: Text(" ").frame(maxWidth: .infinity)
//                            ) {
//                                ForEach(Array(zip(timetables.indices, timetables)), id: \.0) { index, timetable in
//                                    Text(timetable.title)
//                                        .foregroundColor(Color(UIColor.systemBlue))
//                                        .tag(index)
//                                }
//                            }
//                            .pickerStyle(.menu)
//                            .foregroundStyle(.clear)
//                        }
                        //                    .overlay {
                        //                        Picker(
                        //                            "",
                        //                            selection: $selectedDayNumber
                        //                        ) {
                        //                            ForEach(Array(zip(timetables.indices, timetables)), id: \.0) { index, timetable in
                        //                                Text(timetable.title)
                        //                                    .foregroundColor(Color(UIColor.systemBlue))
                        //                                    .tag(index)
                        //                            }
                        //                        }
                        //                        .pickerStyle(.menu)
                    }
                    
                    
                    //                    Picker(
                    //                        "Day \(selectedDayNumber)",
                    //                        systemImage: "chevron.up.chevron.down",
                    //                        selection: $selectedDayNumber
                    //                    ) {
                    //                        ForEach(Array(zip(timetables.indices, timetables)), id: \.0) { index, timetable in
                    //                            Text(timetable.title)
                    //                                .foregroundColor(Color(UIColor.systemBlue))
                    //                                .tag(index)
                    //                        }
                    //                    }
                    //                    .pickerStyle(.menu)
                    //                    .labelStyle(.titleAndIcon)
                    //                }
                    
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
