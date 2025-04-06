import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // TODO: Implement actual authentication
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isAuthenticated = true
            completion(true)
        }
    }
    
    func logout() {
        isAuthenticated = false
    }
}
