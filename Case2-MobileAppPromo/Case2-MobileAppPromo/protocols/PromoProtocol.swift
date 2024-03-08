//
//  PromoProtocol.swift
//  Case2-MobileAppPromo
//
//  Created by M. Syulhan Al Ghofany on 06/03/24.
//

// step 3
import Foundation
import UIKit

protocol ViewToPresenterProtocol: AnyObject{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingPromo()
    func showDetailController(navigationController: UINavigationController, detailURL: URL)
}

protocol PresenterToViewProtocol: AnyObject{
    func showPromo(promoArray: Array<PromoModel>)
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule() -> PromoViewController
    func pushToDetailScreen(navigationConroller: UINavigationController, promoDetailURL: URL)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchPromo()
}

protocol InteractorToPresenterProtocol: AnyObject {
    func promoFetchedSuccess(promoModelArray: Array<PromoModel>)
    func promoFetchFailed()
}
