@testable import Marvel_API_Demo
import XCTest

private final class GeneralCharacterListPresenterSpy: GeneralCharacterListPresenting {
    //MARK: Calls count
    private(set) var presentCharacterListCallsCount = 0
    private(set) var presentCharacterDetailsCallsCount = 0
    private(set) var presentGenericErrorCallsCount = 0
    private(set) var presentLoadingCallsCount = 0
    
    //MARK: Fetched data
    private(set) var total: Int?
    private(set) var characterList: [CharacterModel]?
    private(set) var characterDetails: CharacterModel?
    private(set) var filtering: Bool?
    
    func presentLoading(_ loading: Bool) {
        presentLoadingCallsCount += 1
    }
    
    func presentCharacterList(total: Int, _ response: [CharacterModel], filtering: Bool) {
        presentCharacterListCallsCount += 1
        self.total = total
        self.characterList = response
        self.filtering = filtering
    }
    
    func presentCharacterDetails(_ character: CharacterModel) {
        presentCharacterDetailsCallsCount += 1
        self.characterDetails = character
    }
    
    func presentGenericError() {
        presentGenericErrorCallsCount += 1
    }
}

private final class GeneralCharacterListServiceMock: GeneralCharacterListServicing {
    private(set) var getGeneralCharacterListCallsCount = 0
    
    var result: Result<CharacterListResultModel, APIError> = .failure(.generic(description: ""))
    
    func getGeneralCharacterList(offset: Int, limit: Int, completion: @escaping Completion<CharacterListResultModel>) {
        getGeneralCharacterListCallsCount += 1
        completion(result)
    }
}

final class GeneralCharacterListInteractorTests: XCTestCase {
    private lazy var service = GeneralCharacterListServiceMock()
    private lazy var presenter = GeneralCharacterListPresenterSpy()
    private lazy var dependencies = DependencyContainer()
    private lazy var sut = GeneralCharacterListInteractor(service: service,
                                                          presenter: presenter, pageSize: 2,
                                                          dependencies: dependencies)
    
    private lazy var charactersFirstPage =
    CharacterListResultModel(data: CharactersListModel(total: 6,
                                                       results: [
                                                        CharacterModel(id: 1,
                                                                       name: "Char 1",
                                                                       description: "Desc 1",
                                                                       thumbnail: ThumbnailModel(path: "path 1",
                                                                                                 imageExtension: "jpg")),
                                                        CharacterModel(id: 2,
                                                                       name: "Char 2",
                                                                       description: "Desc 2",
                                                                       thumbnail: ThumbnailModel(path: "path 2",
                                                                                                 imageExtension: "jpg"))
                                                       ]))
    
    private lazy var charactersSecondPage =
    CharacterListResultModel(data: CharactersListModel(total: 6,
                                                       results: [
                                                        CharacterModel(id: 3,
                                                                       name: "Char 3",
                                                                       description: "Desc 3",
                                                                       thumbnail: ThumbnailModel(path: "path 3",
                                                                                                 imageExtension: "jpg")),
                                                        CharacterModel(id: 4,
                                                                       name: "Char 4",
                                                                       description: "Desc 4",
                                                                       thumbnail: ThumbnailModel(path: "path 4",
                                                                                                 imageExtension: "jpg"))
                                                       ]))
    
    private lazy var allCharacters =
    CharacterListResultModel(data: CharactersListModel(total: 6,
                                                       results: [
                                                        CharacterModel(id: 1,
                                                                       name: "Char 1",
                                                                       description: "Desc 1",
                                                                       thumbnail: ThumbnailModel(path: "path 1",
                                                                                                 imageExtension: "jpg")),
                                                        CharacterModel(id: 2,
                                                                       name: "Char 2",
                                                                       description: "Desc 2",
                                                                       thumbnail: ThumbnailModel(path: "path 2",
                                                                                                 imageExtension: "jpg")),
                                                        CharacterModel(id: 3,
                                                                       name: "Char 3",
                                                                       description: "Desc 3",
                                                                       thumbnail: ThumbnailModel(path: "path 3",
                                                                                                 imageExtension: "jpg")),
                                                        CharacterModel(id: 4,
                                                                       name: "Char 4",
                                                                       description: "Desc 4",
                                                                       thumbnail: ThumbnailModel(path: "path 4",
                                                                                                 imageExtension: "jpg"))
                                                       ]))
    
    private lazy var filteredCharacters = [CharacterModel(id: 1, name: "Char 1", description: "Desc 1", thumbnail: ThumbnailModel(path: "path 1",
                                                                                                                                  imageExtension: "jpg"))]
    
    func testLoadInitialCharacters_WhenTaskIsSuccess_ShouldCallPresentCharacterList() {
        service.result = .success(charactersFirstPage)
        sut.loadInitialCharacters()
        XCTAssertEqual(presenter.presentCharacterListCallsCount, 1)
        XCTAssertEqual(presenter.total, 6)
        XCTAssertEqual(presenter.characterList, charactersFirstPage.data.results)
        XCTAssertEqual(presenter.filtering, false)
    }
    
    func testLoadInitialCharacters_WhenTaskIsFailure_ShouldCallPresentGenericError() {
        service.result = .failure(.fetchData)
        sut.loadInitialCharacters()
        XCTAssertEqual(presenter.presentGenericErrorCallsCount, 1)
    }
    
    func testLoadCharacter_WhenTaskIsSuccessAndIndexIsLessThanCurrentOffset_ShouldDoNothing() {
        service.result = .success(charactersFirstPage)
        sut.loadInitialCharacters()
        sut.loadCharacter(index: 1)
        XCTAssertEqual(presenter.presentCharacterListCallsCount, 1)
        XCTAssertEqual(presenter.total, 6)
        XCTAssertEqual(presenter.characterList, charactersFirstPage.data.results)
    }
    
    func testLoadCharacter_WhenTaskIsSuccessAndIndexIsGreaterThanCurrentOffset_ShouldCallPresentCharacterList() {
        service.result = .success(charactersFirstPage)
        sut.loadInitialCharacters()
        service.result = .success(charactersSecondPage)
        sut.loadCharacter(index: 2)
        XCTAssertEqual(presenter.presentCharacterListCallsCount, 2)
        XCTAssertEqual(presenter.total, 6)
        XCTAssertEqual(presenter.characterList, allCharacters.data.results)
        XCTAssertEqual(presenter.filtering, false)
    }
    
    func testLoadCharacter_WhenTaskIsFailure_ShouldCallPresentGenericError() {
        service.result = .success(charactersFirstPage)
        sut.loadInitialCharacters()
        service.result = .failure(.fetchData)
        sut.loadCharacter(index: 2)
        XCTAssertEqual(presenter.presentGenericErrorCallsCount, 1)
    }
    
    func testDidSelectCharacter_ShouldCallPresentCharacterDetails() {
        service.result = .success(charactersFirstPage)
        sut.loadInitialCharacters()
        sut.didSelectCharacter(index: 0)
        XCTAssertEqual(presenter.characterDetails, charactersFirstPage.data.results[0])
    }
    
    func testSearchCharacter_WhenPrefixIsNotEmpty_ShouldCallPresentCharacterList() {
        service.result = .success(charactersFirstPage)
        sut.loadInitialCharacters()
        sut.searchCharacter(withPrefix: "Char 1")
        XCTAssertEqual(presenter.characterList, filteredCharacters)
        XCTAssertEqual(presenter.total, 6)
        XCTAssertEqual(presenter.presentCharacterListCallsCount, 2)
        XCTAssertEqual(presenter.filtering, true)
    }
    
    func testSearchCharacter_WhenPrefixIsEmpty_ShouldcallPresentCharacterList() {
        service.result = .success(charactersFirstPage)
        sut.loadInitialCharacters()
        sut.searchCharacter(withPrefix: "")
        XCTAssertEqual(presenter.characterList, charactersFirstPage.data.results)
        XCTAssertEqual(presenter.total, 6)
        XCTAssertEqual(presenter.presentCharacterListCallsCount, 2)
        XCTAssertEqual(presenter.filtering, false)
    }
}
