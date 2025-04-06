import SwiftUI

struct TeachersView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            List {
                Section("My Teachers") {
                    ForEach(["Mathematics", "Science", "English"], id: \.self) { subject in
                        VStack(alignment: .leading) {
                            Text(subject)
                                .font(.headline)
                            Text("Not assigned")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Teachers")
        }
    }
}
