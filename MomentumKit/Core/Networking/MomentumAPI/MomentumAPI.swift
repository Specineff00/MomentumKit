import Dependencies

protocol MomentumAPI {
  func fetchAllNotes() async throws -> [Note]
  func saveNote(_ note: Note) async throws

  func fetchQuotes() async throws -> [Quote]
  func saveQuote(_ quote: Quote) async throws
}
