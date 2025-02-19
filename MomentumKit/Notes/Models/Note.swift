import Foundation
import SwiftData

struct Note: Codable, Identifiable {
  let id: UUID? //Never send ID
  let text: String
  let category: String?
  let dateCreated: Date
  let priority: Int
}

extension Note {
  static let mock = Note(id: .init(), text: "Pick up dry cleaning", category: "Chores", dateCreated: Date(), priority: 1)
}

extension [Note] {
  static let mock: [Note] = [.mock]
}
