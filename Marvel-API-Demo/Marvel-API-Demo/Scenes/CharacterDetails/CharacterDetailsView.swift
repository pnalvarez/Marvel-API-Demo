import UIKit

final class CharacterDetailsView: UIView {
    //MARK: UI Components
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .fill
        return stack
    }()
    
    private unowned var titleLabel: UILabel
    private unowned var descriptionLabel: UILabel
    private unowned var imageView: UIImageView
    
    //MARK: Lifecycle
    init(titleLabel: UILabel,
         descriptionLabel: UILabel,
         imageView: UIImageView,
         frame: CGRect) {
        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
        self.imageView = imageView
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterDetailsView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(imageView,
                              titleLabel,
                              descriptionLabel)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.left.right.equalToSuperview().inset(64)
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(264)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
