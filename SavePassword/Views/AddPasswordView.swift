import SwiftUI

struct AddPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var passwordManager: PasswordManager
    
    @State private var title = ""
    @State private var username = ""
    @State private var password = ""
    @State private var notes = ""
    @State private var showPassword = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("User", text: $username)
                
                ZStack(alignment: .trailing) {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                
                TextField("Notes", text: $notes, axis: .vertical)
                    .lineLimit(4)
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
} 
