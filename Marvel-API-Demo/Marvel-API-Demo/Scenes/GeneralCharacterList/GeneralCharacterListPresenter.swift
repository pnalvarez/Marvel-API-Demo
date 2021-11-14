protocol GeneralCharacterListPresenting {
    func presentLoading(_ loading: Bool)
    func presentCharacterList(total: Int, _ response: [CharacterModel])
    func presentCharacterDetails(_ character: CharacterModel)
    func presentGenericError()
}

final class GeneralCharacterListPresenter {
    
}
