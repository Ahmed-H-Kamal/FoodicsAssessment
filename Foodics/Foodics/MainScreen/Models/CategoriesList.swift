//
//  CategoriesList.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation

// MARK: - CategoriesList
class CategoriesList: Codable {
    let data: [Category]?
    let links: Links?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case links = "links"
        case meta = "meta"
    }

    init(data: [Category]?, links: Links?, meta: Meta?) {
        self.data = data
        self.links = links
        self.meta = meta
    }
}
