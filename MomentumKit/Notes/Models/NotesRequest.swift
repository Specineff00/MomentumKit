import Foundation

struct NotesRequest: Request {
    typealias ReturnType = [Note]
    var path = "/notes"
}
