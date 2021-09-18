//
//  CategoriesScreenController.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//

import Foundation
protocol SelectProductDelegate {
    func didSelectProductItem(product: Product)
}

class ProductsController: NSObject {
    let viewModel : ProductsViewModel
    
    init(viewModel: ProductsViewModel = ProductsViewModel()) {
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
        
        
        let row_products = getProductsByCategoryViewModels()
        let section_products = SectionViewModel(rowViewModels: row_products, sectionHeight: 0, sectionModel: nil)
        sectionViewModels.append(section_products)
        
        self.viewModel.sectionViewModels.value = sectionViewModels
    }
    
    func getProductsByCategoryViewModels() -> [RowViewModel] {
        var listOfProducts = [RowViewModel]()
        
        for product in self.viewModel.productsList.value {
            let model = ProductTableViewModel(with: product)
            model.didSelectProduct = { product in
                self.viewModel.delegate?.didSelectProductItem(product: product)
                self.viewModel.shouldDismiss.value = true
            }
            listOfProducts.append(model)
        }
        return listOfProducts
    }
}
