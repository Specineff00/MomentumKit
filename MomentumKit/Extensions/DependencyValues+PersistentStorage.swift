import Dependencies

extension DependencyValues {
  var persistentStorage: any PersistentStorage {
    get { self[PersistentStorageKey.self] }
    set { self[PersistentStorageKey.self] = newValue }
  }
}

struct PersistentStorageKey: DependencyKey {
  static var liveValue: PersistentStorage = LivePersistentStorage()
  static var testValue: PersistentStorage = MockPersistentStorage()
}
