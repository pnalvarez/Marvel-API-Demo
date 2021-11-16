import UIKit

enum CharacterDetailsAction {
    //empty
}

protocol CharacterDetailsCoordinating {
    func perform(_ action: CharacterDetailsAction)
}

final class CharacterDetailsCoordinator {
    typealias Dependencies = HasNoDependency
    
    weak var viewController: UIViewController?
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension CharacterDetailsCoordinator: CharacterDetailsCoordinating {
    func perform(_ action: CharacterDetailsAction) {
        switch action {
            //empty
        }
    }
}
