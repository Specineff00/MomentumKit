import Foundation

protocol PersistentStorage {
  func saveNote(_ note: Note)
  func loadNote() -> Note?
}

struct LivePersistentStorage: PersistentStorage {
  func saveNote(_ note: Note) {
  }
  
  func loadNote() -> Note? {
    nil
  }

  // Needs to load all notes to add to notes, but could use swift data
}

struct MockPersistentStorage: PersistentStorage {
  var savedNote: Note?
  
  func saveNote(_ note: Note) {
  }
  
  func loadNote() -> Note? {
    nil
  }
}
