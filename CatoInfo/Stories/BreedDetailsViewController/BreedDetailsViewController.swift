//
//  BreedDetailsViewController.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 05/11/2020.
//

import UIKit
import RxSwift
import RxCocoa
import SCLAlertView


class BreedDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var catPlaceHolderImage: UIImageView!
    @IBOutlet weak var imagesContentView: UIView!
    @IBOutlet weak var catImagesScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    
    @IBOutlet weak var breedTitleLabe: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var detailsStackView: UIStackView!
    
    
    private var viewModel : BreedDetailsViewModel?
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catImagesScrollView.delegate = self
        
        setupUI()
        setupBindings()
        viewModel?.getData()
    }
    
    
    public func set(viewModel: BreedDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupUI() {
        guard let viewModel = self.viewModel else { return }


        
        self.breedTitleLabe.text = viewModel.breed.name
        self.descriptionLabel.text = viewModel.breed.description
        
        self.detailsStackView.addArrangedSubview(viewModel.getDetialsLabels())
        self.detailsStackView.addArrangedSubview(viewModel.getTraitsCheckboxes())
        self.detailsStackView.addArrangedSubview(viewModel.getTraitsStarsViews())
        
        let newFolder = UIAction(title: "New Folder", image: UIImage(systemName: "folder.badge.plus")) { _ in print("NewFolder")}
        let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil.circle")) { _ in print("Edit") }
        let menu = UIMenu(title: "", children: [newFolder, edit])
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: menu)

        
      
    }
    
    private func setupBindings() {
        self.viewModel?.images.observeOn(MainScheduler.instance).subscribe(onNext: { (images) in
            
            self.setupSlideScrollView(imagesUrl: images)
        }).disposed(by: disposeBag)
    
    }
    
    func setupSlideScrollView(imagesUrl : [String]) {
        self.pageControl.numberOfPages = imagesUrl.count
        catImagesScrollView.contentSize = CGSize(width: imagesContentView.frame.width * CGFloat(imagesUrl.count), height: catImagesScrollView.frame.height)
        catImagesScrollView.isPagingEnabled = true
        
        if !imagesUrl.isEmpty {
            DispatchQueue.main.async {
                self.catPlaceHolderImage.isHidden = true
            }
        }

        for i in 0 ..< imagesUrl.count {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: catImagesScrollView.frame.width * CGFloat(i), y: 0, width: catImagesScrollView.frame.width, height: catImagesScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageView.imageFromURL(urlString: imagesUrl[i], placeholderImage: UIImage(named: "cat"))
            catImagesScrollView.addSubview(imageView)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/imagesContentView.frame.width)
        pageControl.currentPage = Int(pageIndex)

        if scrollView.contentOffset.y != 0 {
            scrollView.contentOffset.y = 0
        }
    }

}



