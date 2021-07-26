//
//  ProductModel.swift
//  SampleUI
//
//  Created by Akanksha Gupta on 23/07/21.
//

import Foundation

struct ProductModel: Codable {
    let code: Int?
    let status: String?
    let data: Product?
}

struct Product: Codable {
    let products: [Products]?
}

struct Products: Codable {
    let name: String?
    let price: Price?
    let images: [String]?
}

struct Price: Codable {
    let priceDisplay: String?
    let offerPriceDisplay: String?
    let strikeThroughPriceDisplay: String?
}
