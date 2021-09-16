//
//  MetaModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation

// MARK: - Meta
class Meta: Codable {
    let currentPage: Int?
    let from: Int?
    let lastPage: Int?
    let links: [Link]?
    let path: String?
    let perPage: Int?
    let to: Int?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from = "from"
        case lastPage = "last_page"
        case links = "links"
        case path = "path"
        case perPage = "per_page"
        case to = "to"
        case total = "total"
    }

    init(currentPage: Int?, from: Int?, lastPage: Int?, links: [Link]?, path: String?, perPage: Int?, to: Int?, total: Int?) {
        self.currentPage = currentPage
        self.from = from
        self.lastPage = lastPage
        self.links = links
        self.path = path
        self.perPage = perPage
        self.to = to
        self.total = total
    }
}

// MARK: - Link
class Link: Codable {
    let url: String?
    let label: String?
    let active: Bool?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case label = "label"
        case active = "active"
    }

    init(url: String?, label: String?, active: Bool?) {
        self.url = url
        self.label = label
        self.active = active
    }
}
