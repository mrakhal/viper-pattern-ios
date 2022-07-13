//
//  Presenter.swift
//  Viper-Pattern
//
//  Created by Mochamad Rakha Luthfi Fahsya on 10/07/22.
//

import Foundation

// Object
// Protocol
// Ref to Interactor, Router, View

enum FetchError: Error{
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor?  { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var view: AnyView?
    
    var interactor: AnyInteractor? {
        didSet{
            interactor?.getUsers()
        }
    }
    
    init() {
        interactor?.getUsers()
    }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went Wrong")
        }
    }
}
