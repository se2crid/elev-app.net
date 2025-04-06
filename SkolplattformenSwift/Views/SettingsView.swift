import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            List {
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: Binding(
                        get: { themeManager.currentTheme == .dark },
                        set: { _ in themeManager.toggleTheme() }
                    ))
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
                }
            }
            .navigationTitle("Settings")
        }
    }
}
