//
//  Category.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation

// MARK: - Datum
class Category: Codable {
    let id: String?
    let name: String?
    let nameLocalized: String?
    let reference: String?
    let image: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case nameLocalized = "name_localized"
        case reference = "reference"
        case image = "image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }

    init(id: String?, name: String?, nameLocalized: String?, reference: String?, image: String?, createdAt: String?, updatedAt: String?, deletedAt: String?) {
        self.id = id
        self.name = name
        self.nameLocalized = nameLocalized
        self.reference = reference
        self.image = image
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

