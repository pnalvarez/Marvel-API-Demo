//
//  GeneralCharacterListView.swift
//  Marvel-API-Demo
//
//  Created by Pedro Alvarez on 13/11/21.
//

import UIKit
import SnapKit

final class GeneralCharacterListView: UIView {
    private unowned var tableView: UITableView
    
    init(frame: CGRect,
         tableView: UITableView) {
        self.tableView = tableView
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GeneralCharacterListView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
