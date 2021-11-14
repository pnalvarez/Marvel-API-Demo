import UIKit

enum GeneralCharacterListAction {
    case characterDetails(model: CharacterModel)
}

protocol GeneralCharacterListCoordinating {
    func perform(_ action: GeneralCharacterListAction)
}
