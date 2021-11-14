import UIKit

protocol GeneralCharacterListDisplaying: AnyObject {
    func displayLoading(_ loading: Bool)
    func displayCharacterList(total: Int, _ viewModel: [CharacterViewModel])
    func displayError(_ viewModel: ErrorViewModel)
}

class GeneralCharacterListController: UIViewController {
    
}
