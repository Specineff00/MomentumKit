import Dependencies

protocol DisneesAPI {
  func fetchAllCharacters() async throws -> [DisneyCharacter]
}

struct LiveDisneesAPI: DisneesAPI {
  @Dependency(\.baseService) private var baseService

  func fetchAllCharacters() async throws -> [DisneyCharacter] {
    let response = try await baseService.dispatch(DisneyCharacterListRequest())
    return response.disneyCharacters
  }
}

struct MockDisneesAPI: DisneesAPI {
  let characters: () throws -> [DisneyCharacter]
  init(characters: @escaping () throws -> [DisneyCharacter]) {
    self.characters = characters
  }

  func fetchAllCharacters() async throws -> [DisneyCharacter] {
    try characters()
  }
}
