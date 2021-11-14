protocol GeneralCharacterListServicing {
    func getGeneralCharacterList(offset: Int, limit: Int, completion: @escaping Completion<CharacterListResultModel>)
}

final class GeneralCharacterListService: GeneralCharacterListServicing {
    typealias Dependencies = HasMainQueue
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getGeneralCharacterList(offset: Int,
                                 limit: Int,
                                 completion: @escaping Completion<CharacterListResultModel>) {
        let endpoint: GeneralCharacterListEndpoint = .getCharacterList(offset: offset,
                                                                       limit: limit)
        API<CharacterListResultModel>(endpoint: endpoint).request { result in
            self.dependencies.mainQueue.async {
                completion(result)
            }
        }
    }
}
