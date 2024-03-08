//
//  PromoModel.swift
//  Case2-MobileAppPromo
//
//  Created by M. Syulhan Al Ghofany on 06/03/24.
//

// step 2
import Foundation
//import ObjectMapper

//private let ID = "id"
//private let NAME = "name"
//private let IMAGES_URL = "images_url"
//private let DETAIL = "detail"
//
//class PromoModel: Mappable{
//
//    internal var id: String?
//    internal var name: String?
//    internal var images_url: String?
//    internal var detail: String?
//
//    required init?(map:Map) {
//        mapping(map: map)
//    }
//
//    func mapping(map:Map){
//        id <- map[ID]
//        name <- map[NAME]
//        images_url <- map[IMAGES_URL]
//        detail <- map[DETAIL]
//    }
//}

class PromoModel: Codable {
    var id: Int?
    var name: String?
    var imagesURL: String?
    var detail: String?
    
    init(id: Int?, name: String?, imagesURL: String?, detail: String?) {
        self.id = id
        self.name = name
        self.imagesURL = imagesURL
        self.detail = detail
    }
}
