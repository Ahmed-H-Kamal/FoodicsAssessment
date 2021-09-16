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
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.setupBinding()
        self.getCategories()
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
    
    func getCategories() {
        self.viewModel.isLoading.value = true
        self.viewModel.getCategories() { (response, error) in
            if error == nil{
                if let list = response?.data{
                    self.viewModel.categoriesList.value = list
                }
            }
            self.viewModel.isLoading.value = false
        }
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
                return self.view.frame.size.height - 50
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


