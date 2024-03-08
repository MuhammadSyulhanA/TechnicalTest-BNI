//
//  PromoPresenter.swift
//  Case2-MobileAppPromo
//
//  Created by M. Syulhan Al Ghofany on 06/03/24.
//

// step 5
import Foundation
import UIKit

class PromoPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingPromo() {
        interactor?.fetchPromo()
    }
    
    func showDetailController(navigationController: UINavigationController, detailURL: URL) {
        router?.pushToDetailScreen(navigationConroller: navigationController, promoDetailURL: detailURL)
    }

}

extension PromoPresenter: InteractorToPresenterProtocol{
    
    func promoFetchedSuccess(promoModelArray: Array<PromoModel>) {
        view?.showPromo(promoArray: promoModelArray)
    }
    
    func promoFetchFailed() {
        view?.showError()
    }
    
}
