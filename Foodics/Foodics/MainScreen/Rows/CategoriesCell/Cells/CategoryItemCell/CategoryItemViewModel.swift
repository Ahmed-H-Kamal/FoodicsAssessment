//
//  CategoryItemViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation

class CategoryItemViewModel: NSObject, RowViewModel {
    
    var category:Category?

    init(category: Category?){
        self.category = category
    }
    
    func cellIdentifier() -> String {
        return CategoryItemViewCell.cellIdentifier()
    }

}
