struct ThumbnailModel: Decodable, Equatable {
    let path: String
    let imageExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
