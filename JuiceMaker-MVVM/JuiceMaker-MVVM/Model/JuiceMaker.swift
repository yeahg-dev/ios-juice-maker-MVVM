//
//  JuiceMaker.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift
import UIKit

struct JuiceMaker {
    
    // MARK: - Property
    
    private let fruitRepository = FruitRepository.shared
    private let disposeBag = DisposeBag()
    
    // MARK: - Business Logic
    
    func fruitStockObservable(of fruit: Fruit) -> Observable<Int> {
        fruitRepository.read(fruit)
    }
    
    func makeJuice(_ juice: FruitJuice) -> Observable<FruitJuice> {
        let camMakeJuice = self.hasSufficentIngredients(of: juice)
        
        let juice = camMakeJuice
            .do(onNext: { bool in
                if bool == true {
                    self.consumeIngredients(of: juice)
                }
            })
            .flatMap { bool in
                Observable<FruitJuice>.create { emitter in
                    switch bool {
                    case true:
                        emitter.onNext(juice)
                    case false:
                        emitter.onError(JuiceMakerError.juiceProductionFailure)
                    }
                    return Disposables.create()
                }
            }
                
        return juice
    }
    
    private func hasSufficentIngredients(of juice: FruitJuice) -> Observable<Bool> {
        var isFruitAvailable: [Observable<Bool>] = []
        
        for ingredient in juice.ingredients {
            let fruit = ingredient.key
            let fruitAvailable = self.fruitRepository.read(fruit)
                .flatMap { currentStock in
                    currentStock >= ingredient.value ? Observable<Bool>.just(true) : Observable<Bool>.just(false)
                }
            isFruitAvailable.append(fruitAvailable)
        }
        
        let hasSufficientIngredients = Observable.zip(isFruitAvailable) { availabilty in
            availabilty.contains(false) ? false : true
        }
        
        return hasSufficientIngredients
    }
    
    private func hasSufficientFruit(
        of fruit: Fruit,
        about neededAmount: Int
    ) -> Observable<Bool> {
        let hasSufficeintFruit = fruitRepository.read(fruit)
            .map({stock in stock >= neededAmount})
        
        return hasSufficeintFruit
    }
    
    private func consumeIngredients(of juice: FruitJuice) {
        juice.ingredients.forEach { (fruit, amount) in
            self.fruitRepository.decrease(fruit, by: amount)
        }
    }
    
    func modifyFruitStock(
        of fruit: Fruit,
        with newValue: Int
    ) -> Observable<Void> {
        let isAbleToModifyFruitStock = self.isAbleToModifyFruitStock(of: fruit, with: newValue)
        
        let fruitStockModification = isAbleToModifyFruitStock
            .debug()
            .flatMap { bool in
                Observable<Void>.create { emitter in
                    if bool == true {
                        self.updateFruitRepository(of: fruit, with: newValue)
                        emitter.onNext(())
                    } else {
                        emitter.onError(JuiceMakerError.fruitReductionFailure)
                    }
                    return Disposables.create()
                }
            }
        return fruitStockModification
    }
    
    private func isAbleToModifyFruitStock(
        of fruit: Fruit,
        with newValue: Int
    ) -> Observable<Bool> {
        Observable.create { observer in
            if newValue >= 0 {
                observer.on(.next(true))
            } else {
                observer.on(.next(false))
            }
            return Disposables.create()
        }
    }
    
    private func updateFruitRepository(
        of fruit: Fruit,
        with newValue: Int
    )  {
        self.fruitRepository.update(fruit, with: newValue)
    }
    
}

enum FruitStockModification: ObservableConvertibleType {
    typealias Element = Self
    
    case success
    case deficientFruitStockFailure
    
    func asObservable() -> Observable<FruitStockModification> {
        switch self {
        case .success:
            return Observable<FruitStockModification>.just(.success)
        case .deficientFruitStockFailure:
            return Observable<FruitStockModification>.just(.deficientFruitStockFailure)
        }
    }
}

enum JuiceMakerError: Error {
    
    case juiceProductionFailure
    case fruitReductionFailure
}
