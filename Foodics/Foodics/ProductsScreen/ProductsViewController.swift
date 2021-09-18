//
//  CategoriesScreenViewController.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//

import Foundation
import UIKit

class ProductsViewController: BaseViewController {
    lazy var controller : ProductsController = {
        return ProductsController()
    }()
    
    var viewModel : ProductsViewModel {
        return controller.viewModel
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.setupBinding()
        self.getProductsLocalIfFound()
    }
    
    private func setupBinding() {
        
        /* observing sections */
        self.viewModel.sectionViewModels.addObserver() { [weak self] (sectionViewModels) in
            self?.tableView.reloadData()
        }
        
        self.viewModel.isLoading.addObserver { (isLoading) in
            if isLoading {
                appLoader().showLoading()
            } else {
                appLoader().hideLoading()
            }
        }
        
        self.viewModel.productsList.addObserver() { [weak self] (categories) in
            self?.controller.buildViewModels()
        }
        
        self.viewModel.didSelectProduct = { (id) in

        }
        
        self.viewModel.shouldDismiss.addObserver { (shouldDismiss) in
            if shouldDismiss {
                self.navigationController?.popViewController(animated: true)
            }
        }
        self.viewModel.retryViewButtonClick = {
            self.getProductsLocalIfFound()
        }
        
        self.viewModel.nextButtonPressed = {
            if let next = self.viewModel.links?.next{
                self.getProductsPerPageLocalIfFound(page: next)
            }
        }
        
        self.viewModel.backButtonPressed = {
            if let prev = self.viewModel.links?.prev{
                self.getProductsPerPageLocalIfFound(page: prev)
            }
        }
        
    }
    
    // MARK:- Register Cells
    func registerCells() {
        
        self.tableView.sectionHeaderHeight =  UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 80
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib.init(nibName: NavigationHeaderViewCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: NavigationHeaderViewCell.cellIdentifier())

        self.tableView.register(UINib.init(nibName: ProductTableViewCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: ProductTableViewCell.cellIdentifier())

    }
    
    func getProductsByCategory() {
        self.viewModel.isLoading.value = true
        self.viewModel.getProducts() { (response, error) in
            if error == nil{
                if let links = response?.links{
                    self.viewModel.links = links
                }
                if let list = response?.data{
                    self.viewModel.productsList.value = list
                }
            }else{
                self.addRetryAgainView()
            }
            self.viewModel.isLoading.value = false
        }
    }
    
    func getProductsByCategoryPerPage(page: String) {
        self.viewModel.isLoading.value = true
        self.viewModel.getProductsPerPage(page: page) { (response, error) in
            if error == nil{
                if let links = response?.links{
                    self.viewModel.links = links
                }
                if let list = response?.data{
                    self.viewModel.productsList.value = list
                }
            }else{
                self.addRetryAgainView()
            }
            self.viewModel.isLoading.value = false
        }
    }
    
    
    func getProductsLocalIfFound() {
        if let products = self.viewModel.getSavedProducts(key: Constants.products){
            if let links = products.links{
                self.viewModel.links = links
            }
            if let list = products.data{
                self.viewModel.productsList.value = list
            }
        }else{
            self.getProductsByCategory()
        }
    }
    
    func getProductsPerPageLocalIfFound(page: String) {
        if let products = self.viewModel.getSavedProducts(key: page){
            if let links = products.links{
                self.viewModel.links = links
            }
            if let list = products.data{
                self.viewModel.productsList.value = list
            }
        }else{
            self.getProductsByCategoryPerPage(page: page)
        }
    }
    
    func addRetryAgainView() {
        self.view.showRetryAgainView(retryButtonClick: self.viewModel.retryViewButtonClick, viewModel: RetryAgainViewModel())
    }

}
// MARK:- Table View Data Delegates
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionViewModel = self.viewModel.sectionViewModels.value[section]
        return sectionViewModel.rowViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionViewModel = self.viewModel.sectionViewModels.value[indexPath.section]
        let rowViewModel = sectionViewModel.rowViewModels[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: rowViewModel.cellIdentifier(), for: indexPath)
        
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionViewModel = viewModel.sectionViewModels.value[section]
        return CGFloat(sectionViewModel.sectionHeight)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionViewModel = self.viewModel.sectionViewModels.value[indexPath.section]
        let rowViewModel = sectionViewModel.rowViewModels[indexPath.row]

            switch rowViewModel {
            case is NavigationHeaderViewModel:
                return 50
            case is ProductTableViewModel:
                return 160
            default:
                return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionViewModel = controller.viewModel.sectionViewModels.value[indexPath.section]
        if let rowViewModel = sectionViewModel.rowViewModels[indexPath.row] as? ViewModelPressible {
            rowViewModel.cellPressed()
        }
    }
}


