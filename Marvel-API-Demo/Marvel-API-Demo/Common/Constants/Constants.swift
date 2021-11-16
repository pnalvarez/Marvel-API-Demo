import UIKit

enum Constants {
    static let initialOffset = 0
    static let pageSize = 6
}

enum Strings {
    static let genericErrorTitle = "Ops, ocorreu um erro!"
    static let genericErrorDescription = "Não foi possível carregar esta tela"
    static let characterListTitle = "Lista de personagens"
    static let emptyListTitle = "Lista vazia"
    static let emptyListDescription = "Digite o nome válido de algum personagem ;)"
    static let noDescription = "Sem descrição para este personagem"
    static let http = "http"
    static let https = "https"
    static let dot = "."
    static let connectionLost = "Você perdeu a conexão com a internet."
    static let tryAgain = "Tentar novamente"
}

enum Images {
    static let emptyBox = UIImage(named: "empty-box")
    static let errorIcon = UIImage(named: "error-icon")
}
