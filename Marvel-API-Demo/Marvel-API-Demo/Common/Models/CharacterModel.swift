struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailModel
}
