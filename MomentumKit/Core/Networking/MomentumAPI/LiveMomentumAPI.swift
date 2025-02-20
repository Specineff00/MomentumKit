import Dependencies

struct LiveMomentumAPI: MomentumAPI {
    @Dependency(\.baseService) private var baseService

    func fetchAllNotes() async throws -> [Note] {
        try await baseService.dispatch(NotesRequest())
    }

    func saveNote(_ note: Note) async throws {
        _ = try await baseService.dispatch(SaveNoteRequest(note))
    }

    func fetchQuotes() async throws -> [Quote] {
        try await baseService.dispatch(QuotesRequest())
    }

    func saveQuote(_: Quote) async throws {
        // TODO:
    }
}
