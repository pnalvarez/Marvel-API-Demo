import UIKit

enum GeneralCharacterListAction: Equatable {
    case characterDetails(model: CharacterModel)
}

protocol GeneralCharacterListCoordinating {
    func perform(_ action: GeneralCharacterListAction)
}

final class GeneralCharacterListCoordinator {
    typealias Dependencies = HasNoDependency
    
    weak var viewController: UIViewController?
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

private extension GeneralCharacterListCoordinator {
    func goToCharacterDetails(_ details: CharacterModel) {
        let characterDetailsViewController = CharacterDetailsFactory.make(characterDetails: details)
        viewController?.navigationController?.pushViewController(characterDetailsViewController,
                                                                 animated: true)
    }
}

extension GeneralCharacterListCoordinator: GeneralCharacterListCoordinating {
    func perform(_ action: GeneralCharacterListAction) {
        switch action {
        case let .characterDetails(model):
            goToCharacterDetails(model)
        }
    }
}
