import Foundation

struct PasswordItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var username: String
    var password: String
    var notes: String?
} 