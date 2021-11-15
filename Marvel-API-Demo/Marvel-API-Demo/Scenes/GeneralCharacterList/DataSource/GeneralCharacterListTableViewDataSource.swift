import UIKit

final class GeneralCharacterListTableViewDataSource: NSObject {
    private var total: Int = 0
    private var viewModel: [CharacterViewModel] = []
    private var searchText: String = ""
    
    private var filteredCharacters: [CharacterViewModel] {
        return viewModel.filter( { $0.name.hasPrefix(searchText) })
    }
    
    func setup(total: Int? = nil,
               viewModel: [CharacterViewModel]? = nil,
               searchText: String? = nil) {
        if let total = total {
            self.total = total
        }
        if let viewModel = viewModel {
            self.viewModel = viewModel
        }
        if let searchText = searchText {
            self.searchText = searchText
        }
    }
}

extension GeneralCharacterListTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchText.isEmpty ? total : filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !searchText.isEmpty {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: GeneralCharacterListTableViewCell.self)
            cell.setup(filteredCharacters[indexPath.row])
            return cell
        }
        if indexPath.row > viewModel.count - 1 {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: LoadingTableViewCell.self)
            return cell
        }
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: GeneralCharacterListTableViewCell.self)
        cell.setup(viewModel[indexPath.row])
        return cell
    }
}
