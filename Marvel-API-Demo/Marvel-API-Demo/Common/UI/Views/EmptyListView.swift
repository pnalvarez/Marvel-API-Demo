import UIKit

final class EmptyListView: UIView {
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.emptyBox
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

extension EmptyListView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(iconImageView,
                                      titleLabel,
                                      descriptionLabel)
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(264)
        }
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(64)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
