//
//  ViewController.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 20/10/2020.
//

import UIKit
import RxSwift
import RxCocoa
import SCLAlertView


/*
 ZAGADNIENIA RX
 
 subscribe a bind
 
 behaviorRelay a BehaviorSubject
 Relay a subject
 
 Rx traints
 
 Czy view model moze miec disposeBaga?
 */

class BreedListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : BreedListViewModel?
    
    let disposeBag = DisposeBag()
    
    static func instantiate(viewModel : BreedListViewModel) -> BreedListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        guard let viewController = storyboard.instantiateViewController(identifier: "BreedListViewController") as? BreedListViewController else { return BreedListViewController() }
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBindings()
        self.viewModel?.getData()
    }
    
    private func setupUI() {
        navigationItem.title = viewModel?.title ?? ""
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        
        tableView.register(UINib(nibName: "CatBreedTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: CatBreedTableViewCell.self))
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupBindings() {
        
        viewModel?.cellsViewModels.bind(to: tableView.rx.items(cellIdentifier: "CatBreedTableViewCell")) {
            index, viewModel, cell in
            guard let cell  = cell as? CatBreedTableViewCell else { return }
            cell.viewModel = viewModel
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(CatBreedTableViewCellViewModel.self).subscribe(onNext: { [weak self] model in
            self?.pushBreedDetailsViewControllerWith(breed: model.getBreed())
        
               }).disposed(by: disposeBag)
        
        viewModel?.loadingInProcess.observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        
        viewModel?.error.observeOn(MainScheduler.instance).subscribe(onNext: { (error) in
            SCLAlertView().showCustomError(error: error)
        }).disposed(by: disposeBag)
        
        
    }
    
    
    func pushBreedDetailsViewControllerWith(breed : CatBreed) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "BreedDetailsViewController") as? BreedDetailsViewController else { return }
        vc.set(viewModel: BreedDetailsViewModel(breed: breed))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

