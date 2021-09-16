//
//  ProductTableViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation
import UIKit
class ProductTableViewModel: RowViewModel,ViewModelPressible {
    let product: Product
    var didSelectProduct : ((Product) -> Void)?

    init(with product : Product) {
        self.product = product
    }
    
    func cellIdentifier() -> String {
        return ProductTableViewCell.cellIdentifier()
    }
    
    func cellPressed() {
        self.didSelectProduct?(product)
    }
}
