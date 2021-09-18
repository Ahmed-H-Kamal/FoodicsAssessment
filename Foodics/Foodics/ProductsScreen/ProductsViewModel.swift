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
    var nextButtonPressed : (() -> Void)?
    var backButtonPressed : (() -> Void)?
    var links : Links?
    
    func getProducts(completion: @escaping(_ categories:ProductsList?, _ error: Error?) -> Void)
    {
        let url = Constants.products
        
        ApiManager.makeApiCall(with: url, method: .get) { (response, error) in
            if (error != nil) {
                completion (nil, error!)
            }
            else {
                if let data = response {
                    do {
                        self.saveResponseLocally(data: data, key: url)
                        let decoded = try JSONDecoder().decode(ProductsList.self, from: data)
                        completion (decoded, nil)
                    } catch {
                        print("*** ERROR *** \(error)")
                    }
                }
            }
        }
    }
    
    func getProductsPerPage(page: String, completion: @escaping(_ categories:ProductsList?, _ error: Error?) -> Void)
    {
        let url = page
        
        ApiManager.makeApiCall(with: url, method: .get) { (response, error) in
            if (error != nil) {
                completion (nil, error!)
            }
            else {
                if let data = response {
                    do {
                        self.saveResponseLocally(data: data, key: url)
                        let decoded = try JSONDecoder().decode(ProductsList.self, from: data)
                        completion (decoded, nil)
                    } catch {
                        print("*** ERROR *** \(error)")
                    }
                }
            }
        }
    }
    
    func saveResponseLocally(data: Data?, key: String?) {
        if let data = data, let key = key{
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func getSavedProducts(key: String?) -> ProductsList? {
        if let key = key{
            if let data = UserDefaults.standard.value(forKey: key) as? Data{
                do {
                    let decoded = try JSONDecoder().decode(ProductsList.self, from: data)
                    return decoded
                } catch {
                    print("*** ERROR *** \(error)")
                }
            }
        }
        return nil
    }
    
}
