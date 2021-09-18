//
//  CategoriesScreenViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//

import Foundation
import UIKit

class CategoriesViewModel: NSObject {
    let isLoading = Observable<Bool>(false)
    let sectionViewModels = Observable<[SectionViewModel]>([])
    let categoriesList = Observable<[Category]>([])
    var didSelectCategory : ((String) -> Void)?
    var showProductPopup : ((Product) -> Void)?
    var retryViewButtonClick : (() -> Void)?
    var nextButtonPressed : (() -> Void)?
    var backButtonPressed : (() -> Void)?
    var links : Links?

    func getCategories(completion: @escaping(_ categories:CategoriesList?, _ error: Error?) -> Void)
    {
        let url = "https://api.foodics.dev/v5/categories"
        
        ApiManager.makeApiCall(with: url, method: .get) { (response, error) in
            if (error != nil) {
                completion (nil, error!)
            }
            else {
                if let data = response {
                    do {
                        let decoded = try JSONDecoder().decode(CategoriesList.self, from: data)
                        completion (decoded, nil)
                    } catch {
                        print("*** ERROR *** \(error)")
                    }
                }
            }
        }
    }
    
    func getCategoriesPerPage(page: Int, completion: @escaping(_ categories:CategoriesList?, _ error: Error?) -> Void)
    {
        let url = "https://api.foodics.dev/v5/categories?page=\(String(page))"
        
        ApiManager.makeApiCall(with: url, method: .get) { (response, error) in
            if (error != nil) {
                completion (nil, error!)
            }
            else {
                if let data = response {
                    do {
                        let decoded = try JSONDecoder().decode(CategoriesList.self, from: data)
                        completion (decoded, nil)
                    } catch {
                        print("*** ERROR *** \(error)")
                    }
                }
            }
        }
    }
    
    
    func getCategoriesPerPage(page: String, completion: @escaping(_ categories:CategoriesList?, _ error: Error?) -> Void)
    {
        let url = page
        
        ApiManager.makeApiCall(with: url, method: .get) { (response, error) in
            if (error != nil) {
                completion (nil, error!)
            }
            else {
                if let data = response {
                    do {
                        let decoded = try JSONDecoder().decode(CategoriesList.self, from: data)
                        completion (decoded, nil)
                    } catch {
                        print("*** ERROR *** \(error)")
                    }
                }
            }
        }
    }
    
}
