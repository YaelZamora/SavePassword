import SwiftUI

struct PasswordDetailView: View {
    let password: PasswordItem
    @State private var showPassword = false
    @State private var isAuthenticating = false
    
    var body: some View {
        Form {
            Section("Detalles") {
                HStack {
                    Text("Título")
                    Spacer()
                    Text(password.title).foregroundColor(.gray)
                }
                
                HStack {
                    Text("Usuario")
                    Spacer()
                    Text(password.username).foregroundColor(.gray)
                }
                
                HStack {
                    Text("Contraseña")
                    Spacer()
                    Text(showPassword ? password.password : "••••••••")
                        .foregroundColor(.gray)
                    Button(action: {
                        if !showPassword {
                            authenticateUser()
                        } else {
                            showPassword = false
                        }
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            if let notes = password.notes {
                Section("Notas") {
                    Text(notes)
                }
            }
        }
        .navigationTitle(password.title)
    }
    
    private func authenticateUser() {
        Task {
            let success = await BiometricAuthService.authenticate()
            await MainActor.run {
                if success {
                    showPassword = true
                }
            }
        }
    }
} 
