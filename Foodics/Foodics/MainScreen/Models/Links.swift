//
//  LinksModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation

// MARK: - Links
class Links: Codable {
    let first: String?
    let last: String?
    let prev: String?
    let next: String?

    enum CodingKeys: String, CodingKey {
        case first = "first"
        case last = "last"
        case prev = "prev"
        case next = "next"
    }

    init(first: String?, last: String?, prev: String?, next: String?) {
        self.first = first
        self.last = last
        self.prev = prev
        self.next = next
    }
}
