protocol GeneralCharacterListInteracting {
    func loadInitialCharacters()
    func loadCharacter(index: Int)
    func didSelectCharacter(index: Int)
}

final class GeneralCharacterListInteractor {
    typealias Dependencies = HasNoDependency
    
    private let service: GeneralCharacterListServicing
    private let presenter: GeneralCharacterListPresenting
    private let dependencies: Dependencies
    
    private var currentOffset: Int = Constants.initialOffset
    private var currentLimit: Int = Constants.initialOffset
    private var total: Int = 0
    private var characterList: [CharacterModel] = []
    
    init(service: GeneralCharacterListServicing,
         presenter: GeneralCharacterListPresenting,
         dependencies: Dependencies) {
        self.service = service
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

extension GeneralCharacterListInteractor: GeneralCharacterListInteracting {
    func loadInitialCharacters() {
        presenter.presentLoading(true)
        service.getGeneralCharacterList(offset: currentOffset,
                                        limit: Constants.pageSize) { result in
            self.presenter.presentLoading(false)
            switch result {
            case let .success(model):
                self.total = model.data.total
                self.characterList.append(contentsOf: model.data.results)
                self.currentLimit += Constants.pageSize
                self.currentOffset += Constants.pageSize
                self.presenter.presentCharacterList(total: self.total,
                                                    self.characterList)
            case .failure:
                self.presenter.presentGenericError()
            }
        }
    }
    
    func loadCharacter(index: Int) {
        if index > currentOffset {
            currentOffset = index
            if currentOffset > currentLimit {
                service.getGeneralCharacterList(offset: currentOffset,
                                                limit: Constants.pageSize) { result in
                    switch result {
                    case let .success(model):
                        self.total = model.data.total
                        self.characterList.append(contentsOf: model.data.results)
                        self.currentLimit += Constants.pageSize
                        self.presenter.presentCharacterList(total: self.total,
                                                            self.characterList)
                    case .failure:
                        self.presenter.presentGenericError()
                    }
                }
            }
        }
    }
    
    func didSelectCharacter(index: Int) {
        presenter.presentCharacterDetails(characterList[index])
    }
}
