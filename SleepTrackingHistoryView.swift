//
//  SleepTrackingHistory.swift
//  sleepy
//
//  Created by Dominykas on 25/08/2024.
//

struct SleepTrackingHistoryView: View {
    @State private var sleepSessions: [SleepSession] = []
    
    var body: some View {
        List(sleepSessions) { session in
            VStack(alignment: .leading) {
                Text("Date: \(session.date)")
                Text("Duration: \(session.duration)")
            }
        }
        .onAppear {
            // Fetch sleep sessions from API or database
            sleepSessions = [
                SleepSession(date: "2023-03-01", duration: "8 hours"),
                SleepSession(date: "2023-03-02", duration: "7 hours"),
                SleepSession(date: "2023-03-03", duration: "9 hours")
            ]
        }
    }
}

struct SleepSession: Identifiable {
    let id = UUID()
    let date: String
    let duration: String
}
