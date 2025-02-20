import Foundation
import SwiftData

struct Note: Codable, Identifiable, Equatable {
    let id: UUID? // Never send ID /// correction: it SHOULD!!
    let text: String
    let category: String?
    let dateCreated: Date
    let priority: Int
}

extension Note {
    static func mock(
        id: UUID = .init(),
        text: String = "Pick up dry cleaning",
        category: String? = "Chores",
        dateCreated: Date = .now,
        priority: Int = 1
    ) -> Self {
        .init(
            id: id,
            text: text,
            category: category,
            dateCreated: dateCreated,
            priority: priority
        )
    }
}

extension [Note] {
    static let mock: [Note] = [.mock()]
}

extension Note {
    static func generateRandomNote() -> Note {
        let categories = ["Work", "Personal", "Shopping", "Ideas", "Health", "Travel"]
        let adjectives = ["Quick", "Lazy", "Important", "Urgent", "Interesting", "Random"]
        let nouns = ["Task", "Project", "Item", "Reminder", "Meeting", "Note"]
        let verbs = ["Create", "Review", "Update", "Check", "Discuss", "Plan"]

        let randomText = [
            adjectives.randomElement()!,
            nouns.randomElement()!,
            "to",
            verbs.randomElement()!,
            String(UUID().uuidString.prefix(8)),
        ].joined(separator: " ")

        return Note(
            id: .init(),
            text: randomText,
            category: categories.randomElement()!,
            dateCreated: Date(), priority: Int.random(in: 1 ... 3)
        )
    }
}
