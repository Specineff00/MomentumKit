import Dependencies

protocol MomentumAPI {
  func fetchAllNotes() async throws -> [Note]
  func saveNote(_ note: Note) async throws
}

struct LiveMomentumAPI: MomentumAPI {
  @Dependency(\.baseService) private var baseService

  func fetchAllNotes() async throws -> [Note] {
    try await baseService.dispatch(NotesRequest())
  }

  func saveNote(_ note: Note) async throws {
    _  = try await baseService.dispatch(SaveNoteRequest(note))
  }
}

struct MockMomentumAPI: MomentumAPI {
  let notes: () throws -> [Note]
  init(notes: @escaping () throws -> [Note]) {
    self.notes = notes
  }

  func fetchAllNotes() async throws -> [Note] {
    try notes()
  }

  func saveNote(_ note: Note) async throws {

  }
}
