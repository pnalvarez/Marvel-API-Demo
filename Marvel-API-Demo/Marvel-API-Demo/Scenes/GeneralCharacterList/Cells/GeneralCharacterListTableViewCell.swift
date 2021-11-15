import UIKit
import SDWebImage

final class GeneralCharacterListTableViewCell: UITableViewCell {
    private lazy var titleContainer: UIView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .blue
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ viewModel: CharacterViewModel) {
        titleLabel.text = viewModel.name
        characterImageView.sd_setImage(with: URL(string: viewModel.image.replacingOccurrences(of: "http", with: "https")))
    }
}

extension GeneralCharacterListTableViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        titleContainer.addSubview(titleLabel)
        addSubviews(titleContainer, characterImageView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(16)
        }
        titleContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleContainer.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}
