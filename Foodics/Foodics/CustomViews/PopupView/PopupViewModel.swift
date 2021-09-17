//
//  PopupViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation

class PopupViewModel{
    let didPressClose   = Observable<Bool>(false)
    var product : Product?
    
    init(product: Product) {
        self.product = product
    }
}
