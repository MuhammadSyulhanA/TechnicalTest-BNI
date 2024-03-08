//
//  PromoInteractor.swift
//  Case2-MobileAppPromo
//
//  Created by M. Syulhan Al Ghofany on 06/03/24.
//

// step 6
import Foundation
//import Alamofire
//import ObjectMapper

class PromoInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    
    //    func fetchPromo() {
    //        Alamofire.request(API_PROMO_LIST).responseJSON { response in
    //
    //            if(response.response?.statusCode == 200){
    //                if let json = response.result.value as AnyObject? {
    //                    let arrayResponse = json["promos"] as! NSArray
    //                    print("duarrr: \(arrayResponse)")
    //                    let arrayObject = Mapper<PromoModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]]);
    //                    self.presenter?.promoFetchedSuccess(promoModelArray: arrayObject)
    //                }
    //            }else {
    //                self.presenter?.promoFetchFailed()
    //            }
    //        }
    //    }
    
    func fetchPromo() {
        guard let url = URL(string: API_PROMO_LIST) else {
            self.presenter?.promoFetchFailed()
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjc1OTE0MTUwLCJleHAiOjE2Nzg1MDYxNTB9.TcIgL5CDZYg9o8CUsSjUbbUdsYSaLutOWni88ZBs9S8", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.presenter?.promoFetchFailed()
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let arrayResponse = json?["promos"] as? [[String: Any]] {
                        var promoModelArray = [PromoModel]()
                        for promoDict in arrayResponse {
                            if let id = promoDict["id"] as? Int,
                               let name = promoDict["name"] as? String,
                               let imagesURL = promoDict["images_url"] as? String,
                               let detail = promoDict["detail"] as? String {
                                let promoModel = PromoModel(id: id, name: name, imagesURL: imagesURL, detail: detail)
                                promoModelArray.append(promoModel)
                            }
                        }
                        print("dscscd: \(promoModelArray)")
                        self.presenter?.promoFetchedSuccess(promoModelArray: promoModelArray)
                    } else {
                        self.presenter?.promoFetchFailed()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    self.presenter?.promoFetchFailed()
                }
            } else {
                self.presenter?.promoFetchFailed()
            }
        }
        task.resume()
    }
}
