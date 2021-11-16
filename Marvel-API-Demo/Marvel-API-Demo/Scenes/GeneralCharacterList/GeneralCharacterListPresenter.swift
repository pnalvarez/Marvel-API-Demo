protocol GeneralCharacterListPresenting {
    func presentLoading(_ loading: Bool)
    func presentCharacterList(total: Int, _ response: [CharacterModel], filtering: Bool)
    func presentCharacterDetails(_ character: CharacterModel)
    func presentGenericError()
}

final class GeneralCharacterListPresenter {
    typealias Dependencies = HasNoDependency
    
    weak var viewController: GeneralCharacterListDisplaying?
    private let coordinator: GeneralCharacterListCoordinating
    private let dependencies: Dependencies
    
    init(coordinator: GeneralCharacterListCoordinating,
         dependencies: Dependencies) {
        self.coordinator = coordinator
        self.dependencies = dependencies
    }
}

extension GeneralCharacterListPresenter: GeneralCharacterListPresenting {
    func presentLoading(_ loading: Bool) {
        viewController?.displayLoading(loading)
    }
    
    func presentCharacterList(total: Int, _ response: [CharacterModel], filtering: Bool) {
        let viewModel = response.map({ CharacterViewModel(name: $0.name,
                                                          image: $0.thumbnail.path + Strings.dot + $0.thumbnail.imageExtension) })
        viewController?.displayCharacterList(total: total, viewModel, filtering: filtering)
    }
    
    func presentCharacterDetails(_ character: CharacterModel) {
        coordinator.perform(.characterDetails(model: character))
    }
    
    func presentGenericError() {
        let viewModel = ErrorViewModel(title: Strings.genericErrorTitle,
                                       description: Strings.genericErrorDescription)
        viewController?.displayError(viewModel)
    }
}
