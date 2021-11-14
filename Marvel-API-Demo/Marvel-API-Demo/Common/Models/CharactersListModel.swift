struct CharactersListModel: Decodable, Equatable {
    let total: Int
    let results: [CharacterModel]
}

struct CharacterListResultModel: Decodable, Equatable {
    let data: CharactersListModel
}
