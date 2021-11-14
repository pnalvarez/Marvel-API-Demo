import Foundation

enum GeneralCharacterListEndpoint: APIEndpointExposable {
    case getCharacterList(offset: Int, limit: Int)
    
    var path: String {
        switch self {
        case .getCharacterList:
            return "/characters"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacterList:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .getCharacterList(offset, limit):
            return ["offset": "\(offset)",
                    "limit": "\(limit)"]
        }
    }
    
    var body: Data? {
        switch self {
        case .getCharacterList:
            return nil
        }
    }
}
