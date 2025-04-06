import SwiftUI

@main
struct SkolplattformenApp: App {
    @StateObject private var authManager = AuthenticationManager()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                ContentView()
                    .environmentObject(authManager)
                    .environmentObject(themeManager)
            } else {
                LoginView()
                    .environmentObject(authManager)
                    .environmentObject(themeManager)
            }
        }
    }
}
