import UIKit

enum GeneralCharacterListAction: Equatable {
    case characterDetails(model: CharacterModel)
}

protocol GeneralCharacterListCoordinating {
    func perform(_ action: GeneralCharacterListAction)
}
