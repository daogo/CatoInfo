//
//  BreedDetailsViewModel.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 05/11/2020.
//

import UIKit
import RxSwift
import RxCocoa


struct BreedDetailsViewModel {
    let breed : CatBreed
    
    let apiClient : CatApiClientProtocol

    init(breed: CatBreed, apiClient : CatApiClientProtocol = CatApiClient()) {
        self.breed = breed
        self.apiClient = apiClient
    }
    
    public let images = BehaviorRelay<[String]>(value: [])
    
    let disposeBag = DisposeBag()
    
    
    public func getData() {
        self.fetchImagesFor(breedId: self.breed.id).observeOn(MainScheduler.instance).subscribe { (catImagesUrls) in
            images.accept(catImagesUrls)
        }.disposed(by: disposeBag)
    }
    
    private func fetchImagesFor(breedId : String) -> Observable<[String]> {
        return apiClient.getDataFor(breedId: breedId).map { $0.map {
            return $0.url
            }
        }
    }
    
    func getTraitsCheckboxes() -> UIStackView {
        var traintsArray : [TraitsCheckbox] = []
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        let experimental = TraitsCheckbox()
        experimental.prepareWith(text: "Experimental", value: breed.experimental == 1)
        traintsArray.append(experimental)
        
        let hairless = TraitsCheckbox()
        hairless.prepareWith(text: "Hairless", value: breed.hairless == 1)
        traintsArray.append(hairless)
        
        let hypoallergenic = TraitsCheckbox()
        hypoallergenic.prepareWith(text: "Hypoallergenic", value: breed.hypoallergenic == 1)
        traintsArray.append(hypoallergenic)
        
        let natural = TraitsCheckbox()
        natural.prepareWith(text: "Natural", value: breed.natural == 1)
        traintsArray.append(natural)
        
        let rare = TraitsCheckbox()
        rare.prepareWith(text: "Rare", value: breed.rare == 1)
        traintsArray.append(rare)
        
        let rex = TraitsCheckbox()
        rex.prepareWith(text: "Rex", value: breed.rex == 1)
        traintsArray.append(rex)
        
        let short_legs = TraitsCheckbox()
        short_legs.prepareWith(text: "Short Legs", value: breed.short_legs == 1)
        traintsArray.append(short_legs)
        
        let suppressed_tail = TraitsCheckbox()
        suppressed_tail.prepareWith(text: "Suppressed Tail", value: breed.suppressed_tail == 1)
        traintsArray.append(suppressed_tail)
        
        traintsArray.forEach{ stackView.addArrangedSubview($0) }
        return stackView
    }
    
    func getTraitsStarsViews() -> UIStackView {
        var traintsStarsArray : [TraitsStarView] = []
        let stackView = UIStackView()
        stackView.axis = .vertical
    
        if let adaptability = breed.adaptability {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Adaptability", rating: adaptability)
            traintsStarsArray.append(starView)
        }
        
        if let affectionLevel = breed.affection_level {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Affection Level", rating: affectionLevel)
            traintsStarsArray.append(starView)
        }
        
        if let child_friendly = breed.child_friendly {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Child Friendly", rating: child_friendly)
            traintsStarsArray.append(starView)
        }
        
        if let dog_friendly = breed.dog_friendly {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Dog Friendly", rating: dog_friendly)
            traintsStarsArray.append(starView)
        }
        
        if let energy_level = breed.energy_level {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Energy Level", rating: energy_level)
            traintsStarsArray.append(starView)
        }

        if let grooming = breed.grooming {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Grooming", rating: grooming)
            traintsStarsArray.append(starView)
        }
        
        if let health_issues = breed.health_issues {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Health Issues", rating: health_issues)
            traintsStarsArray.append(starView)
        }
        
        if let intelligence = breed.intelligence {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Intelligence", rating: intelligence)
            traintsStarsArray.append(starView)
        }
        
        if let shedding_level = breed.shedding_level {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Shedding Level", rating: shedding_level)
            traintsStarsArray.append(starView)
        }
        
        if let social_needs = breed.social_needs {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Social Needs", rating: social_needs)
            traintsStarsArray.append(starView)
        }
        
        if let stranger_friendly = breed.stranger_friendly {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Stranger Friendly", rating: stranger_friendly)
            traintsStarsArray.append(starView)
        }
        
        if let vocalisation = breed.vocalisation {
            let starView = TraitsStarView()
            starView.prepareWith(text: "Vocalisation", rating: vocalisation)
            traintsStarsArray.append(starView)
        }
        
        traintsStarsArray.forEach{ stackView.addArrangedSubview($0) }
        
        return stackView
    }
    
    func getDetialsLabels() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        var detialsLabelsArray : [UILabel] = []
        
        let temperamentLabel = UILabel()
        temperamentLabel.text = "Temperament: \(breed.temperament)"
        detialsLabelsArray.append(temperamentLabel)
        
        let lifeSpanLabel = UILabel()
        lifeSpanLabel.text = "Life Span: \(breed.life_span) years"
        detialsLabelsArray.append(lifeSpanLabel)
        
        let originLabel = UILabel()
        originLabel.text = "Origin: \(breed.origin)"
        detialsLabelsArray.append(originLabel)
    
        detialsLabelsArray.forEach { $0.set(numberOfLines: 0) }
        detialsLabelsArray.forEach{ stackView.addArrangedSubview($0) }
        
        return stackView
    }
        

}
