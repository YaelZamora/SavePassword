import Foundation
import SwiftUI

class PasswordManager: ObservableObject {
    @Published var passwords: [PasswordItem] = []
    
    private let saveKey = "SavedPasswords"
    
    init() {
        loadPasswords()
    }
    
    func addPassword(_ item: PasswordItem) {
        passwords.append(item)
        savePasswords()
    }
    
    func deletePassword(at offsets: IndexSet) {
        passwords.remove(atOffsets: offsets)
        savePasswords()
    }
    
    private func savePasswords() {
        if let encoded = try? JSONEncoder().encode(passwords) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadPasswords() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([PasswordItem].self, from: data) {
                passwords = decoded
            }
        }
    }
} 