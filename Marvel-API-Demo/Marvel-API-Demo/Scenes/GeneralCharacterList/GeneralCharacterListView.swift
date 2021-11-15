import UIKit
import SnapKit

final class GeneralCharacterListView: UIView {
    private unowned var tableView: UITableView
    private unowned var activityView: UIActivityIndicatorView
    
    init(frame: CGRect,
         tableView: UITableView,
         activityView: UIActivityIndicatorView) {
        self.tableView = tableView
        self.activityView = activityView
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GeneralCharacterListView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubviews(tableView, activityView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        activityView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
