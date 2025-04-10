//
//  Timetable.swift
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/09.
//

struct Timetable: Decodable, Identifiable {
    let id: Int
    let title: String
    let date: String
    let schedules: [Schedule]
}

extension Timetable {
    func getSessionStatus(for id: Schedule.ID) -> SessionStatus? {
        // TODO: Improve performance
        // TODO:
        let sortedSchedules = schedules.sorted {
            guard let date0 = $0.date, let date1 = $1.date else {
                return false
            }
            return date0 < date1
        }
        guard
            let index = sortedSchedules.firstIndex(where: { $0.id == id }),
            index < schedules.count - 1,
            let date = sortedSchedules[index].date,
            let nextDate = sortedSchedules[index + 1].date
        else {
            return nil
        }
        
        return if date > .now {
            .preparing
        } else if date <= .now && .now < nextDate {
            .ongoing
        } else {
            .finished
        }
    }
}

enum SessionStatus {
    case preparing
    case ongoing
    case finished
    
    var description: String {
        switch self {
        case .preparing:
            "準備中"
        case .ongoing:
            "進行中"
        case .finished:
            "終了"
        }
    }
}
