import SwiftUI

struct PasswordDetailView: View {
    let password: PasswordItem
    @State private var showPassword = false
    
    var body: some View {
        Form {
            Section("Details") {
                LabeledContent("Title", value: password.title)
                LabeledContent("User", value: password.username)
                
                HStack {
                    Text("Password")
                    Spacer()
                    Text(showPassword ? password.password : "••••••••")
                        .foregroundColor(.gray)
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            if let notes = password.notes {
                Section("Notes") {
                    Text(notes)
                }
            }
        }
        .navigationTitle(password.title)
    }
} 
