//
//  PromoRouter.swift
//  Case2-MobileAppPromo
//
//  Created by M. Syulhan Al Ghofany on 06/03/24.
//

// step 8
import Foundation
import UIKit

class PromoRouter: PresenterToRouterProtocol{
    
    static func createModule() -> PromoViewController {
        
        let view = PromoViewController()
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = PromoPresenter()
        let interactor: PresenterToInteractorProtocol = PromoInteractor()
        let router:PresenterToRouterProtocol = PromoRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    func pushToDetailScreen(navigationConroller navigationController: UINavigationController, promoDetailURL: URL) {
        
//        let detailModule = DetailPromoRouter.createModule()
//        navigationController.pushViewController(detailModule,animated: true)
        let detailModule = DetailPromoViewController()
        detailModule.promoDetailURL = promoDetailURL
        navigationController.pushViewController(detailModule, animated: true)
    }
}
