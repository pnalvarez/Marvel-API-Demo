enum GeneralCharacterListFactory {
    static func make(pageSize: Int) -> GeneralCharacterListController {
        let dependencyContainer = DependencyContainer()
        let service = GeneralCharacterListService(dependencies: dependencyContainer)
        let coordinator = GeneralCharacterListCoordinator(dependencies: dependencyContainer)
        let presenter = GeneralCharacterListPresenter(coordinator: coordinator, dependencies: dependencyContainer)
        let interactor = GeneralCharacterListInteractor(service: service,
                                                        presenter: presenter,
                                                        pageSize: pageSize,
                                                        dependencies: dependencyContainer)
        let viewController = GeneralCharacterListController(interactor: interactor)
        presenter.viewController = viewController
        coordinator.viewController = viewController
        return viewController
    }
}
