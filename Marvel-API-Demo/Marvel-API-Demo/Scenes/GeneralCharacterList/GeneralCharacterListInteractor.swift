protocol GeneralCharacterListInteracting {
    func loadInitialCharacters()
    func loadCharacter(index: Int)
    func didSelectCharacter(index: Int)
    func searchCharacter(withPrefix prefix: String)
}

final class GeneralCharacterListInteractor {
    typealias Dependencies = HasNoDependency
    
    private let service: GeneralCharacterListServicing
    private let presenter: GeneralCharacterListPresenting
    private let dependencies: Dependencies
    
    private var currentOffset: Int = Constants.initialOffset
    private var total: Int = 0
    private var characterList: [CharacterModel] = []
    private let pageSize: Int
    
    init(service: GeneralCharacterListServicing,
         presenter: GeneralCharacterListPresenting,
         pageSize: Int,
         dependencies: Dependencies) {
        self.service = service
        self.presenter = presenter
        self.pageSize = pageSize
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
                self.currentOffset += self.pageSize-1
                self.presenter.presentCharacterList(total: self.total,
                                                    self.characterList,
                                                    filtering: false)
            case .failure:
                self.presenter.presentGenericError()
            }
        }
    }
    
    func loadCharacter(index: Int) {
        if index > currentOffset {
            currentOffset += pageSize
            service.getGeneralCharacterList(offset: currentOffset,
                                            limit: pageSize) { result in
                switch result {
                case let .success(model):
                    self.total = model.data.total
                    self.characterList.append(contentsOf: model.data.results)
                    self.presenter.presentCharacterList(total: self.total,
                                                        self.characterList,
                                                        filtering: false)
                case .failure:
                    self.presenter.presentGenericError()
                }
            }
        }
    }
    
    func didSelectCharacter(index: Int) {
        presenter.presentCharacterDetails(characterList[index])
    }
    
    func searchCharacter(withPrefix prefix: String) {
        let filteredCharacters = characterList.filter({ $0.name.hasPrefix(prefix) })
        presenter.presentCharacterList(total: total,
                                       filteredCharacters,
                                       filtering: !prefix.isEmpty)
    }
}
