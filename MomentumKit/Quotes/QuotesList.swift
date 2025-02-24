import ComposableArchitecture
import SwiftUI

struct QuotesList: View {
    let store: StoreOf<QuotesFeature>

    var body: some View {
        List(store.quotes) { note in
            Text(note.text)
                .appFont(.body)
        }
        .onAppear {
            store.send(.loadQuotes)
        }
    }
}

// TODO: previews
