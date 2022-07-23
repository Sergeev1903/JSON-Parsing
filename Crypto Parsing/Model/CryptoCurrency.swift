//
//  CryptoCurrency.swift
//  JSON Parsing
//
//  Created by Артем Сергеев on 22.07.2022.
//

import Foundation
import UIKit

struct CryptoCurrency: Decodable {
    
    let id: String?
    let name: String?
    let price: Float?
    
    enum CodingKeys: String, CodingKey {
        case id = "asset_id"
        case name
        case price = "price_usd"
    }
}

struct Icon: Decodable {
    let asset_id: String?
    let url: String?
}
