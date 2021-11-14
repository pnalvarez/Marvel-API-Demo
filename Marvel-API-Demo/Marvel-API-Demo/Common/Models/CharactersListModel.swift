struct CharactersListModel: Decodable {
    let total: Int
    let results: [CharacterModel]
}

struct CharacterListResultModel: Decodable {
    let data: CharactersListModel
}
