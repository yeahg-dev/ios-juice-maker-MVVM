//
//  JuiceMaker.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift

struct JuiceMaker {
    
    // MARK: - Property
    
    private let fruitRepository = FruitRepository.shared
    private let disposeBag = DisposeBag()
    
    // MARK: - Business Logic
    
    func fruitStockObservable(of fruit: Fruit) -> Observable<Int> {
        fruitRepository.read(fruit)
    }
    
    // TODO: - 역할 분리
    func makeJuice(_ juice: FruitJuice) -> Observable<FruitJuice?> {
        let numberOfFruitToCheck = juice.ingredients.count
        
        // Subject내 아이템이 모두 true일 경우에만 FruitJuice 방출
        let juiceObservable = self.hasSufficentIngredients(of: juice)
            .map({result in result == true ? juice : nil})
            .do(onNext: { juice in
                guard let juiceToMake = juice else {
                   return
                }
                self.consumeIngredients(of: juiceToMake)
            })
                
        return juiceObservable
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
    ) -> Observable<FruitStockModification> {
        let isAbleToModifyFruitStock = self.isAbleToModifyFruitStock(of: fruit, with: newValue)
        
        let fruitStockModification = isAbleToModifyFruitStock
            .flatMap { bool -> Observable<FruitStockModification> in
                if bool == true {
                    return self.updateFruitRepository(of: fruit, with: newValue)
                        .filter { bool in
                            bool == true
                        }
                        .flatMap { _ in
                            Observable<FruitStockModification>.just(.success)
                        }
                } else {
                    return Observable<FruitStockModification>.just(.deficientFruitStockFailure)
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
    ) -> Observable<Bool> {
        return self.fruitRepository.update(fruit, with: newValue)
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
