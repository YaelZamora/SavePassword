import SwiftUI

struct PasswordDetailView: View {
    let password: PasswordItem
    @State private var showPassword = false
    @State private var isAuthenticating = false
    
    var body: some View {
        Form {
            Section("Detalles") {
                LabeledContent("Título", value: password.title)
                LabeledContent("Usuario", value: password.username)
                
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
