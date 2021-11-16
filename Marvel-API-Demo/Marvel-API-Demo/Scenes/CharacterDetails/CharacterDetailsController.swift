import UIKit

protocol CharacterDetailsDisplaying: AnyObject {
    func displayCharacterDetails(_ viewModel: CharacterDetailsViewModel)
}

final class CharacterDetailsController: UIViewController {
    typealias Dependencies = HasNoDependency
    
    //MARK: UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var mainView: CharacterDetailsView = CharacterDetailsView(titleLabel: titleLabel,
                                                                           descriptionLabel: descriptionLabel,
                                                                           imageView: characterImageView,
                                                                           frame: .zero)
    
    //MARK: VIP Layers
    private let interactor: CharacterDetailsInteracting
    
    //MARK: Dependencies
    private let dependencies: Dependencies
    
    //MARK: Lifecycle
    init(interactor: CharacterDetailsInteracting,
         dependencies: Dependencies) {
        self.interactor = interactor
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchCharacterDetails()
    }
}

extension CharacterDetailsController: CharacterDetailsDisplaying {
    func displayCharacterDetails(_ viewModel: CharacterDetailsViewModel) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        characterImageView.sd_setImage(with: URL(string: viewModel.image))
    }
}
