import Foundation

struct SaveNoteRequest: Request {
    typealias ReturnType = Note
    var path = "/notes"
    var method: HTTPMethod = .post
    var body: Codable?

    init(_ note: Note) {
        body = Note( // Strips ID
            id: nil,
            text: note.text,
            category: note.category,
            dateCreated: note.dateCreated,
            priority: note.priority
        )
    }
}
