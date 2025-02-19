import Foundation

struct Quote: Codable, Identifiable, Equatable {
  let id: UUID
  let text: String
  let author: String?
  let category: String
}

extension Quote {
  static func mock(
    id: UUID = .init(),
    text: String = "Be the change you wish to see in the world",
    author: String? = "Mahatma Gandhi",
    category: String = "Inspiration"
  ) -> Self {
    .init(
      id: id,
      text: text,
      author: author,
      category: category
    )
  }
}
