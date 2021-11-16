protocol CharacterDetailsInteracting {
    func fetchCharacterDetails()
}

final class CharacterDetailsInteractor {
    typealias Dependencies = HasNoDependency
    
    //MARK: VIP layers
    private let presenter: CharacterDetailsPresenting
    
    //MARK: Business Logic
    private let characterDetails: CharacterModel
    
    //MARK: Dependencies
    private let dependencies: Dependencies
    
    //MARK: Lifecycle
    init(presenter: CharacterDetailsPresenting,
         characterDetails: CharacterModel,
         dependencies: Dependencies) {
        self.presenter = presenter
        self.characterDetails = characterDetails
        self.dependencies = dependencies
    }
}

extension CharacterDetailsInteractor: CharacterDetailsInteracting {
    func fetchCharacterDetails() {
        presenter.presentCharacterDetails(characterDetails)
    }
}
