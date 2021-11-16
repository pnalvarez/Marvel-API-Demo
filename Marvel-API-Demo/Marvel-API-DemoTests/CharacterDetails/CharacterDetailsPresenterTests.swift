@testable import Marvel_API_Demo
import XCTest

private final class CharacterDetailsViewControllerSpy: CharacterDetailsDisplaying {
    //MARK: Calls count
    private(set) var displayCharacterDetailsCallsCount = 0
    
    //MARK: Data
    private(set) var characterDetails: CharacterDetailsViewModel?
    
    func displayCharacterDetails(_ viewModel: CharacterDetailsViewModel) {
        displayCharacterDetailsCallsCount += 1
        characterDetails = viewModel
    }
}

private final class CharacterDetailsCoordinatorSpy: CharacterDetailsCoordinating {
    //MARK: Calls count
    private(set) var performCallsCount = 0
    
    //MARK: Data
    private(set) var action: CharacterDetailsAction?
    
    func perform(_ action: CharacterDetailsAction) {

    }
}

final class CharacterDetailsPresenterTests: XCTestCase {
    private lazy var viewController = CharacterDetailsViewControllerSpy()
    private lazy var coordinator = CharacterDetailsCoordinatorSpy()
    private lazy var dependencies = DependencyContainer()
    private lazy var sut: CharacterDetailsPresenter = {
        let presenter = CharacterDetailsPresenter(coordinator: coordinator)
        presenter.viewController = viewController
        return presenter
    }()
    
    private lazy var characterDetails = CharacterModel(id: 1,
                                                       name: "Char",
                                                       description: "Desc",
                                                       thumbnail: ThumbnailModel(path: "path",
                                                                                 imageExtension: "jpg"))
    private lazy var viewModel = CharacterDetailsViewModel(name: "Char", description: "Desc", image: "path.jpg")
    
    func testPresentCharacterDetails_ShouldCallDisplayCharacterDetails() {
        sut.presentCharacterDetails(characterDetails)
        XCTAssertEqual(viewController.displayCharacterDetailsCallsCount, 1)
        XCTAssertEqual(viewController.characterDetails, viewModel)
    }
}
