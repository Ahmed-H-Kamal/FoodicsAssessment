//
//  CategoriesScreenViewController.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//

import Foundation
import UIKit

class CategoriesViewController: BaseViewController {
    lazy var controller : CategoriesController = {
        return CategoriesController()
    }()
    
    var viewModel : CategoriesViewModel {
        return controller.viewModel
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.setupBinding()
        self.getCategoriesLocalIfFound()
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
        
        self.viewModel.categoriesList.addObserver() { [weak self] (categories) in
            self?.controller.buildViewModels()
        }
        
        self.viewModel.didSelectCategory = { (id) in
            self.goToProductsScreen()
        }
        
        self.viewModel.showProductPopup = { (product) in
            self.view.showPopup(viewModel: PopupViewModel(product: product))
        }
        
        self.viewModel.retryViewButtonClick = {
            self.getCategoriesLocalIfFound()
        }
        
        self.viewModel.nextButtonPressed = {
            if let next = self.viewModel.links?.next{
                self.getCategoriesPerPageLocalIfFound(pageLink: next)
            }
        }
        
        self.viewModel.backButtonPressed = {
            if let prev = self.viewModel.links?.prev{
                self.getCategoriesPerPageLocalIfFound(pageLink: prev)
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
        
        self.tableView.register(UINib.init(nibName: CategoriesViewCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: CategoriesViewCell.cellIdentifier())

    }
    
    func getCategoriesLocalIfFound() {
        if let categories = self.viewModel.getSavedCategories(key: Constants.categories){
            if let links = categories.links{
                self.viewModel.links = links
            }
            if let list = categories.data{
                self.viewModel.categoriesList.value = list
            }
        }else{
            self.getCategories()
        }
    }
    func getCategoriesPerPageLocalIfFound(pageLink: String) {
        if let categories = self.viewModel.getSavedCategories(key: pageLink){
            if let links = categories.links{
                self.viewModel.links = links
            }
            if let list = categories.data{
                self.viewModel.categoriesList.value = list
            }
        }else{
            self.getCategoriesPerPage(pageLink: pageLink)
        }
    }
    func getCategories() {
        self.viewModel.isLoading.value = true
        self.viewModel.getCategories() { (response, error) in
            if error == nil{
                if let links = response?.links{
                    self.viewModel.links = links
                }
                if let list = response?.data{
                    self.viewModel.categoriesList.value = list
                }
            }else{
                self.addRetryAgainView()
            }
            self.viewModel.isLoading.value = false
        }
    }    
    func getCategoriesPerPage(pageLink: String) {
        self.viewModel.isLoading.value = true
        self.viewModel.getCategoriesPerPage(page: pageLink) { (response, error) in
            if error == nil{
                if let links = response?.links{
                    self.viewModel.links = links
                }
                if let list = response?.data{
                    self.viewModel.categoriesList.value = list
                }
            }else{
                self.addRetryAgainView()
            }
            self.viewModel.isLoading.value = false
        }
    }
    
    func goToProductsScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as? ProductsViewController {
            controller.viewModel.delegate = self.controller
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    func addRetryAgainView() {
        self.view.showRetryAgainView(retryButtonClick: self.viewModel.retryViewButtonClick, viewModel: RetryAgainViewModel())
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.tableView.reloadData()
        }, completion: { context in
        })
    }
}
// MARK:- Table View Data Delegates
extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource
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
            case is CategoriesListViewModel:
                return self.view.frame.size.height + 50
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


