import SwiftUI

struct AddPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var passwordManager: PasswordManager
    
    @State private var title = ""
    @State private var username = ""
    @State private var password = ""
    @State private var notes = "Notes"
    @State private var showPassword = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("User", text: $username)
                
                ZStack(alignment: .trailing) {
                    if showPassword {
                        TextField("Contraseña", text: $password)
                    } else {
                        SecureField("Contraseña", text: $password)
                    }
                    
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
                
                TextEditor(text: $notes).lineLimit(4).foregroundColor(.gray)
            }
            .navigationTitle("New Password")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    let newPassword = PasswordItem(
                        title: title,
                        username: username,
                        password: password,
                        notes: notes.isEmpty ? nil : notes
                    )
                    passwordManager.addPassword(newPassword)
                    dismiss()
                }
                .disabled(title.isEmpty || username.isEmpty || password.isEmpty)
            )
        }
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
