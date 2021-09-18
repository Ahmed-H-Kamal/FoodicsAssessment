//
//  CategoriesScreenController.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//

import Foundation

class CategoriesController: NSObject, SelectProductDelegate {
    
    let viewModel : CategoriesViewModel
    
    init(viewModel: CategoriesViewModel = CategoriesViewModel()) {
        self.viewModel = viewModel
    }
    
    // MARK:- Build View Models
    func buildViewModels() {
        var sectionViewModels = [SectionViewModel]()

        let row_header = NavigationHeaderViewModel(with: self.viewModel.links)
        row_header.didClickNextButton = {
            self.viewModel.nextButtonPressed?()
        }
        row_header.didClickBackButton = {
            self.viewModel.backButtonPressed?()
        }
        let section_header = SectionViewModel(rowViewModels: [row_header], sectionHeight: 0, sectionModel: nil)
        sectionViewModels.append(section_header)
        
        
        let row_categories = CategoriesListViewModel(with: self.viewModel.categoriesList.value)
        row_categories.didSelectCategory = { (id) in
            self.viewModel.didSelectCategory?(id)
        }
        let section_categories = SectionViewModel(rowViewModels: [row_categories], sectionHeight: 0, sectionModel: nil)
        sectionViewModels.append(section_categories)
        

        
        self.viewModel.sectionViewModels.value = sectionViewModels
    }
    
    func didSelectProductItem(product: Product) {
        self.viewModel.showProductPopup?(product)
    }
    
}
