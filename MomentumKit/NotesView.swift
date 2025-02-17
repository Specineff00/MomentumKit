import ComposableArchitecture
import SwiftData
import SwiftUI

struct NotesView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var notes: [Note]
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
//            store.send(.saveText(text))
            modelContext.insert(Note(text: Date().description))
          }
          Button("Delete") {
//            store.send(.saveText(text))
            try! modelContext.delete(model: Note.self)
          }
          List {
            ForEach(notes) { note in
              Text(note.text)
            }
            .onDelete(perform: deleteNotes)
          }
        }
        .padding()
    }

  private func deleteNotes(offsets: IndexSet) {
      for index in offsets {
          modelContext.delete(notes[index])
      }
  }


  private func saveChanges() {
      do {
          try modelContext.save()
      } catch {
          print("Failed to save context: \(error)")
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
