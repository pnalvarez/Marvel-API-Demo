protocol CharacterDetailsPresenting {
    func presentCharacterDetails(_ response: CharacterModel)
}

final class CharacterDetailsPresenter {
    //MARK: VIP Layers
    weak var viewController: CharacterDetailsDisplaying?
    private let coordinator: CharacterDetailsCoordinating
    
    init(coordinator: CharacterDetailsCoordinating) {
        self.coordinator = coordinator
    }
    
}

extension CharacterDetailsPresenter: CharacterDetailsPresenting {
    func presentCharacterDetails(_ response: CharacterModel) {
        let viewModel = CharacterDetailsViewModel(name: response.name,
                                                  description: response.description.isEmpty ? Strings.noDescription : response.description,
                                                  image: response.thumbnail.path.replacingOccurrences(of: Strings.http, with: Strings.https) + Strings.dot + response.thumbnail.imageExtension)
        viewController?.displayCharacterDetails(viewModel)
    }
}
