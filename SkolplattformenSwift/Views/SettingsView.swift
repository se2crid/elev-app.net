import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var notificationsEnabled = true
    @State private var showResetConfirmation = false
    @AppStorage("selectedLanguage") private var selectedLanguage = "en"
    
    var body: some View {
        NavigationView {
            List {
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: Binding(
                        get: { themeManager.currentTheme == .dark },
                        set: { _ in themeManager.toggleTheme() }
                    ))
                    Picker("Language", selection: $selectedLanguage) {
                        Text("English").tag("en")
                        Text("Svenska").tag("sv")
                    }
                }
                
                Section("Notifications") {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    NavigationLink("Notification Settings") {
                        NotificationSettingsView()
                    }
                }
                
                Section("Data & Storage") {
                    Button("Clear Cache") {
                        showResetConfirmation = true
                    }
                    .foregroundColor(.red)
                }
                
                Section("Account") {
                    Button(role: .destructive, action: {
                        authManager.logout()
                    }) {
                        Text("Log Out")
                    }
                }
                
                Section("About") {
                    LabeledContent("Version", value: "1.0.0")
                    LabeledContent("Build", value: "2024.1")
                    NavigationLink("Privacy Policy") {
                        PrivacyPolicyView()
                    }
                    NavigationLink("Terms of Service") {
                        TermsOfServiceView()
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Clear Cache", isPresented: $showResetConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Clear", role: .destructive) {
                    clearCache()
                }
            } message: {
                Text("Are you sure you want to clear the app cache?")
            }
        }
    }
    
    private func clearCache() {
        // Implement cache clearing
    }
}

struct NotificationSettingsView: View {
    @State private var scheduleChanges = true
    @State private var newGrades = true
    @State private var homework = true
    
    var body: some View {
        List {
            Toggle("Schedule Changes", isOn: $scheduleChanges)
            Toggle("New Grades", isOn: $newGrades)
            Toggle("Homework Reminders", isOn: $homework)
        }
        .navigationTitle("Notification Settings")
    }
}
