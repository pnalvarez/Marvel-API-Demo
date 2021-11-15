import UIKit

final class LoadingTableViewCell: UITableViewCell {
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.backgroundColor = .gray
        view.tintColor = .white
        view.color = .white
        view.startAnimating()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingTableViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(activityView)
    }
    
    func setupConstraints() {
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
    func configureViews() {
        backgroundColor = .gray
    }
}
