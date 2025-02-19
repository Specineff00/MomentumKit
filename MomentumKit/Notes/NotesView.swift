import ComposableArchitecture
import SwiftUI

struct NotesView: View {
  var notes: [Note] = []
  @State private var text = ""
  let store: StoreOf<NoteFeature>

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
      TextField("YO", text: $text)
        .shadow(radius: 3)
        .padding()
        .overlay {
          RoundedRectangle(cornerRadius: 8)
            .stroke(lineWidth: 1)
        }
      Button("Submit") {
        store.send(.saveNote(.generateRandomNote()))
      }
      Button("Delete") {
        //            store.send(.saveText(text))
      }
      List {
        ForEach(notes) { note in
          Text(note.text)
        }
      }
    }
    .padding()
    .onAppear {
      store.send(.onAppear)
    }
  }
}

#Preview {
  NotesView(store: .init(initialState: NoteFeature.State()) {
      NoteFeature()
    }
  )
}



struct NotesList: View {
  let notes: [Note]

  var body: some View {
    List(notes, id: \.text) { note in
      Text(note.text)
    }
  }
}

/*
 TODO:
 - UI to be able input text and looks relatively functional
 - Return doesnt save but could! user testing needed
 - Button at the bottom that save
 - Reminder manager to
 - Note page is modal and therefore when dismissed should have notes list underneath or some kind of thing

 Coming Features
 - Quotes from quote API

 */

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
          String(UUID().uuidString.prefix(8))
      ].joined(separator: " ")

      return Note(
          id: nil,
          text: randomText,
          category: categories.randomElement()!,
          dateCreated: Date(), priority: Int.random(in: 1...3)
      )
  }
}
