//
//  CategoriesListViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation

class CategoriesListViewModel: RowViewModel {
    let isLoading = Observable<Bool>(false)
    let sectionViewModels = Observable<[SectionViewModel]>([])
    let categoriesList : [Category]
    var didSelectCategory : ((String) -> Void)?

    init(with categoriesList : [Category]) {
        self.categoriesList = categoriesList
    }
    
    func cellIdentifier() -> String {
        return CategoriesViewCell.cellIdentifier()
    }
    
}
