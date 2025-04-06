import SwiftUI

struct TeachersView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredTeachers) { teacher in
                    NavigationLink(destination: TeacherDetailView(teacher: teacher)) {
                        TeacherRow(teacher: teacher)
                    }
                }
            }
            .navigationTitle("Teachers")
            .searchable(text: $searchText, prompt: "Search teachers")
        }
    }
    
    private var filteredTeachers: [Teacher] {
        if searchText.isEmpty {
            return teachers
        }
        return teachers.filter { $0.name.localizedCaseInsensitiveContains(searchText) || 
                               $0.subject.localizedCaseInsensitiveContains(searchText) }
    }
    
    private let teachers = [
        Teacher(name: "John Smith", subject: "Mathematics", email: "john.smith@school.edu", room: "A123"),
        Teacher(name: "Sarah Johnson", subject: "Science", email: "sarah.j@school.edu", room: "B201"),
        Teacher(name: "Michael Brown", subject: "English", email: "m.brown@school.edu", room: "C305")
    ]
}

struct Teacher: Identifiable {
    let id = UUID()
    let name: String
    let subject: String
    let email: String
    let room: String
}

struct TeacherRow: View {
    let teacher: Teacher
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(teacher.name)
                .font(.headline)
            Text(teacher.subject)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}

struct TeacherDetailView: View {
    let teacher: Teacher
    
    var body: some View {
        List {
            Section {
                LabeledContent("Subject", value: teacher.subject)
                LabeledContent("Room", value: teacher.room)
                Button {
                    sendEmail(to: teacher.email)
                } label: {
                    LabeledContent("Email", value: teacher.email)
                }
            }
        }
        .navigationTitle(teacher.name)
    }
    
    private func sendEmail(to address: String) {
        guard let url = URL(string: "mailto:\(address)") else { return }
        UIApplication.shared.open(url)
    }
}
