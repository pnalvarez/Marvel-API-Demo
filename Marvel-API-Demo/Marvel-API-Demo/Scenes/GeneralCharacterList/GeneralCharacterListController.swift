import UIKit

protocol GeneralCharacterListDisplaying: AnyObject {
    func displayLoading(_ loading: Bool)
    func displayCharacterList(total: Int, _ viewModel: [CharacterViewModel])
    func displayError(_ viewModel: ErrorViewModel)
}

class GeneralCharacterListController: UIViewController {
    //MARK: UI properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(cellType: GeneralCharacterListTableViewCell.self)
        tableView.registerCell(cellType: LoadingTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.dataSource = dataSource
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar(frame: .zero)
        view.tintColor = .white
        view.backgroundColor = .gray
        view.delegate = self
        view.sizeToFit()
        return view
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.backgroundColor = .black
        view.tintColor = .white
        view.hidesWhenStopped = true
        view.isHidden = true
        return view
    }()
    
    private lazy var mainView: GeneralCharacterListView = GeneralCharacterListView(frame: .zero,
                                                                                   tableView: tableView,             activityView: activityView)
    
    //MARK: VIP layers
    private let interactor: GeneralCharacterListInteracting
    
    //MARK: Design patterns
    private let dataSource = GeneralCharacterListTableViewDataSource()
    
    init(interactor: GeneralCharacterListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.loadInitialCharacters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GeneralCharacterListController {
    func showLoading() {
        activityView.isHidden = false
        activityView.startAnimating()
    }
    
    func stopLoading() {
        activityView.stopAnimating()
    }
    
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .gray
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView = searchBar
        navigationItem.title = Strings.characterListTitle
    }
}

extension GeneralCharacterListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        dataSource.setup(total: <#T##Int#>, viewModel: <#T##[CharacterViewModel]#>)
//        tableView.reloadData()
    }
}

extension GeneralCharacterListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectCharacter(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        interactor.loadCharacter(index: indexPath.row)
    }
}

extension GeneralCharacterListController: GeneralCharacterListDisplaying {
    func displayLoading(_ loading: Bool) {
        loading ? showLoading() : stopLoading()
    }
    
    func displayCharacterList(total: Int, _ viewModel: [CharacterViewModel]) {
        dataSource.setup(total: total, viewModel: viewModel)
        tableView.reloadData()
    }
    
    func displayError(_ viewModel: ErrorViewModel) {
        //TO DO
    }
}
