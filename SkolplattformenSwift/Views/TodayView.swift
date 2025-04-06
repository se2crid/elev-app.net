import SwiftUI

struct TodayView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
                
                Section("Schedule") {
                    ForEach(getDaySchedule(), id: \.id) { lesson in
                        LessonRow(lesson: lesson)
                    }
                }
                
                Section("Homework") {
                    ForEach(getHomework(), id: \.id) { homework in
                        HomeworkRow(homework: homework)
                    }
                }
            }
            .navigationTitle("Today")
            .refreshable {
                // Refresh data
            }
        }
    }
    
    private struct Lesson: Identifiable {
        let id = UUID()
        let time: String
        let subject: String
        let room: String
    }
    
    private struct Homework: Identifiable {
        let id = UUID()
        let subject: String
        let task: String
        let dueDate: Date
    }
    
    private func getDaySchedule() -> [Lesson] {
        return [
            Lesson(time: "08:00 - 09:30", subject: "Mathematics", room: "A123"),
            Lesson(time: "09:45 - 11:15", subject: "Science", room: "B456")
        ]
    }
    
    private func getHomework() -> [Homework] {
        return [
            Homework(subject: "Mathematics", task: "Algebra exercises", dueDate: Date().addingTimeInterval(86400))
        ]
    }
}

struct LessonRow: View {
    let lesson: TodayView.Lesson
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(lesson.time)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(lesson.subject)
                .font(.headline)
            Text("Room \(lesson.room)")
                .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}

struct HomeworkRow: View {
    let homework: TodayView.Homework
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(homework.subject)
                .font(.headline)
            Text(homework.task)
            Text("Due: \(homework.dueDate.formatted(.dateTime.day().month()))")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
