protocol GeneralCharacterListServicing {
    func getGeneralCharacterList(offset: Int, limit: Int, completion: @escaping Completion<CharactersListModel>)
}

final class GeneralCharacterListService: GeneralCharacterListServicing {
    
    func getGeneralCharacterList(offset: Int,
                                 limit: Int,
                                 completion: @escaping Completion<CharactersListModel>) {
        let endpoint: GeneralCharacterListEndpoint = .getCharacterList(offset: offset,
                                                                       limit: limit)
        API<CharacterListResultModel>(endpoint: endpoint).request { result in
            completion(result)
        }
    }
}
