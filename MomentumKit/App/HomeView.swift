import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    @State private var text = ""
    @State var store: StoreOf<AppFeature>

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
            Button("Create") {
                store.send(.createNote)
            }
            .buttonStyle(.momentumSecondary)
            .padding()
            Button("Submit") {
                store.send(.notes(.saveNote(.generateRandomNote())))
            }
            .buttonStyle(.momentumPrimary)
            NotesList(store: store.scope(state: \.notes, action: \.notes))
            QuotesList(store: store.scope(state: \.quotes, action: \.quotes))
        }
        .padding()
        .sheet(item: $store.scope(
            state: \.destination?.createNote,
            action: \.destination.createNote
        )) { createNoteStore in
            CreateNoteView(store: createNoteStore)
        }
        .background(.background)
    }
}

#Preview {
    HomeView(store: .init(initialState: AppFeature.State()) {
        AppFeature()
    })
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

struct CreateNoteView: View {
    @State var store: StoreOf<CreateNoteFeature>
    var body: some View {
        Text("Hello, World!")
        Button("Save note") {
            store.send(.saveNote)
        }
    }
}
