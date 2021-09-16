//
//  Product.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation

// MARK: - product
class Product: Codable {
    let category: Category?
    let ingredients: [String]?
    let id: String?
    let sku: String?
    let barcode: String?
    let name: String?
    let nameLocalized: String?
    let productDescription: String?
    let descriptionLocalized: String?
    let image: String?
    let isActive: Bool?
    let isStockProduct: Bool?
    let isReady: Bool?
    let pricingMethod: Int?
    let sellingMethod: Int?
    let costingMethod: Int?
    let preparationTime: String?
    let price: Double?
    let cost: Double?
    let calories: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case category = "category"
        case ingredients = "ingredients"
        case id = "id"
        case sku = "sku"
        case barcode = "barcode"
        case name = "name"
        case nameLocalized = "name_localized"
        case productDescription = "description"
        case descriptionLocalized = "description_localized"
        case image = "image"
        case isActive = "is_active"
        case isStockProduct = "is_stock_product"
        case isReady = "is_ready"
        case pricingMethod = "pricing_method"
        case sellingMethod = "selling_method"
        case costingMethod = "costing_method"
        case preparationTime = "preparation_time"
        case price = "price"
        case cost = "cost"
        case calories = "calories"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }

    init(category: Category?, ingredients: [String]?, id: String?, sku: String?, barcode: String?, name: String?, nameLocalized: String?, productDescription: String?, descriptionLocalized: String?, image: String?, isActive: Bool?, isStockProduct: Bool?, isReady: Bool?, pricingMethod: Int?, sellingMethod: Int?, costingMethod: Int?, preparationTime: String?, price: Double?, cost: Double?, calories: String?, createdAt: String?, updatedAt: String?, deletedAt: String?) {
        self.category = category
        self.ingredients = ingredients
        self.id = id
        self.sku = sku
        self.barcode = barcode
        self.name = name
        self.nameLocalized = nameLocalized
        self.productDescription = productDescription
        self.descriptionLocalized = descriptionLocalized
        self.image = image
        self.isActive = isActive
        self.isStockProduct = isStockProduct
        self.isReady = isReady
        self.pricingMethod = pricingMethod
        self.sellingMethod = sellingMethod
        self.costingMethod = costingMethod
        self.preparationTime = preparationTime
        self.price = price
        self.cost = cost
        self.calories = calories
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
