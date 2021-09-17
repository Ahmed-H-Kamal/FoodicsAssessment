//
//  CategoriesScreenViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//

import Foundation
import UIKit

class ProductsViewModel: NSObject {
    let isLoading = Observable<Bool>(false)
    let sectionViewModels = Observable<[SectionViewModel]>([])
    let productsList = Observable<[Product]>([])
    var didSelectProduct : ((Product) -> Void)?
    var delegate : SelectProductDelegate?
    let shouldDismiss = Observable<Bool>(false)
    var retryViewButtonClick : (() -> Void)?
    
    func getProducts(completion: @escaping(_ categories:ProductsList?, _ error: Error?) -> Void)
    {
        let url = "https://api.foodics.dev/v5/products?include=category"
        
        ApiManager.makeApiCall(with: url, method: .get) { (response, error) in
            if (error != nil) {
                completion (nil, error!)
            }
            else {
                if let data = response {
                    do {
                        let decoded = try JSONDecoder().decode(ProductsList.self, from: data)
                        completion (decoded, nil)
                    } catch {
                        print("*** ERROR *** \(error)")
                    }
                }
            }
        }
    }
    
    
}
