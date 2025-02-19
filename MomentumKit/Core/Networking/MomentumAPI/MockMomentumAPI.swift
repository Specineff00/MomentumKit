import Foundation

struct MockMomentumAPI: MomentumAPI {
  let notes: () throws -> [Note]
  let quotes: () throws -> [Quote]

  init(
    notes: @escaping () throws -> [Note],
    quotes: @escaping() throws -> [Quote]
  ) {
    self.notes = notes
    self.quotes = quotes
  }

  func fetchAllNotes() async throws -> [Note] {
    try notes()
  }

  func saveNote(_ note: Note) async throws {
    // TODO:
  }

  func fetchQuotes() async throws -> [Quote] {
    try quotes()
  }

  func saveQuote(_ quote: Quote) async throws {
    // TODO:
  }
}
