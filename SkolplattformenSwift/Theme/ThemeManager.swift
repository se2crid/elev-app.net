import SwiftUI

enum Theme {
    case light, dark
    
    var backgroundColor: Color {
        switch self {
        case .light:
            return Color(.systemBackground)
        case .dark:
            return Color(.systemBackground)
        }
    }
    
    var textColor: Color {
        switch self {
        case .light:
            return Color(.label)
        case .dark:
            return Color(.label)
        }
    }
}

class ThemeManager: ObservableObject {
    @Published var currentTheme: Theme = .light
    
    func toggleTheme() {
        currentTheme = currentTheme == .light ? .dark : .light
    }
}
