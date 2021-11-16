enum CharacterDetailsFactory {
    static func make(characterDetails: CharacterModel) -> CharacterDetailsController {
        let dependencyContainer = DependencyContainer()
        let coordinator = CharacterDetailsCoordinator(dependencies: dependencyContainer)
        let presenter = CharacterDetailsPresenter(coordinator: coordinator)
        let interactor = CharacterDetailsInteractor(presenter: presenter,
                                                    characterDetails: characterDetails,
                                                    dependencies: dependencyContainer)
        let viewController = CharacterDetailsController(interactor: interactor,
                                                        dependencies: dependencyContainer)
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
