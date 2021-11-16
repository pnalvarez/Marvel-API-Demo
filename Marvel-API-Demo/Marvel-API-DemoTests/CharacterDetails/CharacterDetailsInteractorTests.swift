@testable import Marvel_API_Demo
import XCTest

private final class CharacterDetailsPresenterSpy: CharacterDetailsPresenting {
    //MARK: Calls count
    private(set) var presentCharacterDetailsCallsCount = 0
    
    //MARK: Fetched data
    private(set) var characterDetails: CharacterModel?
    
    func presentCharacterDetails(_ response: CharacterModel) {
        presentCharacterDetailsCallsCount += 1
        characterDetails = response
    }
}

final class CharacterDetailsInteractorTests: XCTestCase {
    private lazy var presenter = CharacterDetailsPresenterSpy()
    private lazy var sut = CharacterDetailsInteractor(presenter: presenter,
                                                      characterDetails: characterDetails,
                                                      dependencies: DependencyContainer())
    private lazy var characterDetails = CharacterModel(id: 1,
                                                       name: "Char",
                                                       description: "Desc",
                                                       thumbnail: ThumbnailModel(path: "path",
                                                                                 imageExtension: "jpg"))
    
    func testFetchCharacterDetails_ShouldCallPresentCharacterDetails() {
        sut.fetchCharacterDetails()
        XCTAssertEqual(presenter.presentCharacterDetailsCallsCount, 1)
        XCTAssertEqual(presenter.characterDetails, characterDetails)
    }
}
