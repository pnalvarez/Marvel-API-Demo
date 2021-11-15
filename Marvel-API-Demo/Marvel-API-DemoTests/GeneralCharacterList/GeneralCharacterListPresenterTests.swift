@testable import Marvel_API_Demo
import XCTest

private final class GeneralCharacterListViewControllerSpy: GeneralCharacterListDisplaying {
    //MARK: Calls count
    private(set) var displayLoadingCallsCount = 0
    private(set) var displayCharacterListCallsCount = 0
    private(set) var displayErrorCallsCount = 0
    
    //MARK: Fetched data
    private(set) var total: Int?
    private(set) var characters: [CharacterViewModel]?
    private(set) var error: ErrorViewModel?
    private(set) var filtering: Bool?
    
    func displayLoading(_ loading: Bool) {
        displayLoadingCallsCount += 1
    }
    
    func displayCharacterList(total: Int, _ viewModel: [CharacterViewModel], filtering: Bool) {
        displayCharacterListCallsCount += 1
        self.total = total
        self.characters = viewModel
        self.filtering = filtering
    }
    
    func displayError(_ viewModel: ErrorViewModel) {
        displayErrorCallsCount += 1
        self.error = viewModel
    }
}

private final class GeneralCharacterListCoordinatorSpy: GeneralCharacterListCoordinating {
    //MARK: Calls count
    private(set) var performCallsCount = 0
    
    //MARK: Data
    private(set) var action: GeneralCharacterListAction?
    
    func perform(_ action: GeneralCharacterListAction) {
        performCallsCount += 1
        self.action = action
    }
}

final class GeneralCharacterListPresenterTests: XCTestCase {
    private lazy var viewController = GeneralCharacterListViewControllerSpy()
    private lazy var coordinator = GeneralCharacterListCoordinatorSpy()
    private lazy var dependencies = DependencyContainer()
    private lazy var sut: GeneralCharacterListPresenter = {
        let presenter = GeneralCharacterListPresenter(coordinator: coordinator,
                                                      dependencies: dependencies)
        presenter.viewController = viewController
        return presenter
    }()
    
    private lazy var characterList = [CharacterModel(id: 1,
                                                    name: "Char 1",
                                                    description: "Desc 1",
                                                    thumbnail: ThumbnailModel(path: "path 1",
                                                                              imageExtension: "jpg")),
                                     CharacterModel(id: 2,
                                                    name: "Char 2",
                                                    description: "Desc 2",
                                                    thumbnail: ThumbnailModel(path: "path 2",
                                                                              imageExtension: "jpg"))
                                    ]
    
    private lazy var characterListViewModel = [CharacterViewModel(name: "Char 1", image: "path 1.jpg"),
         CharacterViewModel(name: "Char 2", image: "path 2.jpg")]
    
    func testPresentLoading_ShouldCallDisplayLoading() {
        sut.presentLoading(true)
        XCTAssertEqual(viewController.displayLoadingCallsCount, 1)
    }
    
    func testPresentCharacterList_ShouldCallDisplayCharacterList() {
        sut.presentCharacterList(total: 5, characterList, filtering: true)
        XCTAssertEqual(viewController.displayCharacterListCallsCount, 1)
        XCTAssertEqual(viewController.characters, characterListViewModel)
        XCTAssertEqual(viewController.total, 5)
        XCTAssertEqual(viewController.filtering, true)
    }
    
    func testPresentCharacterDetails_ShouldCallPerform() {
        let model = CharacterModel(id: 0, name: "Char", description: "Desc", thumbnail: ThumbnailModel(path: "Path", imageExtension: "jpg"))
        sut.presentCharacterDetails(model)
        XCTAssertEqual(coordinator.performCallsCount, 1)
        XCTAssertEqual(coordinator.action, .characterDetails(model: model))
    }
    
    func testPresentGenericError_ShouldCallDisplayGenericError() {
        sut.presentGenericError()
        XCTAssertEqual(viewController.displayErrorCallsCount, 1)
        XCTAssertEqual(viewController.error, ErrorViewModel(title: "Ops, ocorreu um erro!", description: "Não foi possível carregar esta tela"))
    }
}
