
import Foundation

struct Messages: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
