struct CharacterModel: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailModel
}
