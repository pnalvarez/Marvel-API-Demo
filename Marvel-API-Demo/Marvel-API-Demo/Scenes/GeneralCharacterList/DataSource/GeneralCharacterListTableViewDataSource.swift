import UIKit

final class GeneralCharacterListTableViewDataSource: NSObject {
    private var total: Int = 0
    private var viewModel: [CharacterViewModel] = []
    private var filtering: Bool = false

    func setup(total: Int? = nil,
               viewModel: [CharacterViewModel]? = nil,
               filtering: Bool = false) {
        if let total = total {
            self.total = total
        }
        if let viewModel = viewModel {
            self.viewModel = viewModel
        }
        self.filtering = filtering
    }
}

extension GeneralCharacterListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtering ? viewModel.count : total
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
