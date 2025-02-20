import ComposableArchitecture
import SwiftUI
import WaterfallGrid

struct NotesList: View {
    let store: StoreOf<NotesFeature>
    var body: some View {
        ScrollView {
            WaterfallGrid(store.notes) { note in
                NoteBubble(note: note)
            }
        }
        .onAppear {
//            store.send(.onAppear) //TODO: fix this to not call live in previews
        }
    }
}

// TODO: previews
struct NoteBubble: View {
    let note: Note
    var body: some View {
        Text(note.text)
            .font(.caption)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.gray)
            .cornerRadius(8)
    }
}

#Preview {
    NotesList(store: .init(
        initialState: NotesFeature.State(
            notes: [
                .mock(),
                .generateRandomNote(),
                .generateRandomNote(),
                .generateRandomNote(),
                .generateRandomNote(),
                .generateRandomNote(),
                .mock(text: "Take over the world"),
            ]
        ),
        reducer: { NotesFeature() }
    ))
}
