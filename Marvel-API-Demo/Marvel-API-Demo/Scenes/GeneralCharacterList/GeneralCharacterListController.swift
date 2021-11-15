import UIKit

protocol GeneralCharacterListDisplaying: AnyObject {
    func displayLoading(_ loading: Bool)
    func displayCharacterList(total: Int, _ viewModel: [CharacterViewModel])
    func displayError(_ viewModel: ErrorViewModel)
}

class GeneralCharacterListController: UIViewController {
    //MARK: UI properties
  
    //MARK: VIP layers
    private let interactor: GeneralCharacterListInteracting
    
    init(interactor: GeneralCharacterListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.characterListTitle
        interactor.loadInitialCharacters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
