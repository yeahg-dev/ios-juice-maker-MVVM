//
//  JuiceMaker.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift

struct JuiceMaker {
    
    private let fruitRepository = FruitRepository.shared
    private let disposeBag = DisposeBag()
    
    func fruitStockObservable(of fruit: Fruit) -> Observable<Int> {
        fruitRepository.read(fruit)
    }
    
    // TODO: - 역할 분리
    func makeJuice(_ juice: FruitJuice) -> Observable<FruitJuice?> {
        let numberOfFruitToCheck = juice.ingredients.count
        
        // Subject내 아이템이 모두 true일 경우에만 FruitJuice 방출
        let juiceObservable = self.hasSufficentIngredients(of: juice)
            .take(numberOfFruitToCheck)
            .scan(into: []) { $0.append($1) }
            .map({result in result.contains(false) ? false : true})
            .map({result in result == true ? juice : nil})
            .do(onNext: { juice in
                guard let juiceToMake = juice else {
                   return
                }
                self.consumeIngredients(of: juiceToMake)
            })
                
        return juiceObservable
    }
    
    private func hasSufficentIngredients(of juice: FruitJuice) -> BehaviorSubject<Bool> {
        // 쥬스 재료로 사용될 과일의 가용여부 담을 subject
        let hasSufficientIngredients = BehaviorSubject<Bool>(value: false)
        
        juice.ingredients.forEach { (fruit, amount) in
            self.hasSufficientFruit(of: fruit, about: amount)
                .subscribe(onNext: { result in
                    hasSufficientIngredients.onNext(result)
                }).disposed(by: disposeBag)
        }
        
        return hasSufficientIngredients
    }
    
    private func hasSufficientFruit(of fruit: Fruit, about neededAmount: Int) -> Observable<Bool> {
        let hasSufficeintFruit = fruitRepository.read(fruit)
            .map({stock in stock >= neededAmount})
        
        return hasSufficeintFruit
    }
    
    private func consumeIngredients(of juice: FruitJuice) {
        juice.ingredients.forEach { (fruit, amount) in
            self.fruitRepository.decrease(fruit, by: amount)
        }
    }
    
    func modifiedFruitStockObservable(of fruit: Fruit, with newValue: Int) -> Observable<Int> {
        Observable<Int>.create { observer in
            self.isAbleToModifyFruitStock(of: fruit, with: newValue)
                .subscribe { result in
                    if result.element == true {
                        self.requestModifyFruitStock(of: fruit, with: newValue)
                            .subscribe(onNext: {result in
                                if result == FruitRepository.Result.success {
                                    observer.onNext(newValue)
                                }
                            }).disposed(by: disposeBag)
                    } else if result.element == false {
                        observer.onError(JuiceMakerError.deficientFruitStock)
                    }
                }.disposed(by: disposeBag)
            return Disposables.create()
        }
    }
    
    private func requestModifyFruitStock(of fruit: Fruit, with newValue: Int) -> Observable<FruitRepository.Result> {
        return self.fruitRepository.update(fruit, with: newValue)
    }
    
    private func isAbleToModifyFruitStock(of fruit: Fruit, with newValue: Int) -> Observable<Bool> {
        Observable.create { observer in
            if newValue < 0 {
                observer.on(.next(true))
            } else {
                observer.on(.next(false))
            }
            return Disposables.create()
        }
    }
    
}

extension JuiceMaker {
    
    enum JuiceMakerError: Error {
        
        case deficientFruitStock
    }
}
