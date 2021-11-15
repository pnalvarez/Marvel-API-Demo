import UIKit

protocol ViewCodeProtocol where Self: UIView {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeProtocol {
    func configureViews() { }
    
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
