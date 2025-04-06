import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var themeManager: ThemeManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoading = false
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 60))
                    .foregroundColor(themeManager.currentTheme == .dark ? .white : .blue)
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: performLogin) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(username.isEmpty || password.isEmpty || isLoading)
            }
            .padding()
            .alert("Login Failed", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle("Skolplattformen")
        }
    }
    
    private func performLogin() {
        isLoading = true
        authManager.login(username: username, password: password) { success in
            isLoading = false
            if !success {
                showError = true
            }
        }
    }
}
