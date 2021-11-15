import UIKit

final class GeneralCharacterListTableViewDataSource: NSObject {
    private var total: Int = 0
    private var viewModel: [CharacterViewModel] = []
    
    func setup(total: Int,
               viewModel: [CharacterViewModel]) {
        self.total = total
        self.viewModel = viewModel
    }
}

extension GeneralCharacterListTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > viewModel.count - 1 {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: LoadingTableViewCell.self)
            return cell
        }
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: GeneralCharacterListTableViewCell.self)
        cell.setup(viewModel[indexPath.row])
        return cell
    }
}
