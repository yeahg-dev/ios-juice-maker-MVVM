//
//  FruitStockViewModel.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift

final class FruitStockViewModel {
    
    // MARK: - Property
    
    private let juiceMaker = JuiceMaker()
    
    private let userNotification = PublishSubject<UserNotification>()

    // MARK: - Input/Output
    
    struct Input {
        let strawberryStepperValueObservable: Observable<Double>?
        let peachStepperValueObservable: Observable<Double>?
        let pineappeldStepperValueObservable: Observable<Double>?
        let watermelonStepperValueObservable: Observable<Double>?
        let bananaStepperValueObservable: Observable<Double>?
    }
    
    struct Output {
        let strawberryStockObservable: Observable<String>?
        let peachStockObservable: Observable<String>?
        let pineappleStockObservable: Observable<String>?
        let watermelonStockObservable: Observable<String>?
        let bananaStockObservable: Observable<String>?
        let notificationObservable: Observable<UserNotification>?
    }
    
    // MARK: - bindViewModel
    
    func transform(input: Input) -> Output {
        let strawberryStock = transform(of: .strawberry, input: input)
        let peachStock = transform(of: .peach, input: input)
        let pineappleStock = transform(of: .pineapple, input: input)
        let watermelonStock = transform(of: .watermelon, input: input)
        let bananaStock = transform(of: .banana, input: input)
       
        return Output(strawberryStockObservable: strawberryStock,
                      peachStockObservable: peachStock,
                      pineappleStockObservable: pineappleStock,
                      watermelonStockObservable: watermelonStock,
                      bananaStockObservable: bananaStock,
                      notificationObservable: userNotification)
    }
    
    private func transform(of fruit: Fruit, input: Input) -> Observable<String> {
        var initialStock: Observable<Int>
        var stepperValue: Observable<Int>
        var stockUpdateResult: Observable<Void>
        var updatedStock: Observable<String>
        
        initialStock = self.juiceMaker.fruitStockObservable(of: fruit).take(1)
        
        switch fruit {
        case .strawberry:
            stepperValue = input.strawberryStepperValueObservable?
                .map{Int($0)} ?? Observable<Int>.just(0)
        case .peach:
            stepperValue = input.peachStepperValueObservable?
                .map{Int($0)} ?? Observable<Int>.just(0)
          
        case .banana:
            stepperValue = input.bananaStepperValueObservable?
                .map{Int($0)} ?? Observable<Int>.just(0)
        case .pineapple:
            stepperValue = input.pineappeldStepperValueObservable?
                .map{Int($0)} ?? Observable<Int>.just(0)
        case .watermelon:
            stepperValue = input.watermelonStepperValueObservable?
                .map{Int($0)} ?? Observable<Int>.just(0)
        }
        
        stockUpdateResult = Observable<Int>
            .combineLatest(initialStock, stepperValue){ $0 + $1}
            .flatMap {
            self.juiceMaker.modifyFruitStock(of: fruit, with: $0)
            }
            .share(replay: 1)
        
        updatedStock = stockUpdateResult
            .withUnretained(self)
            .do(onError: { _ in
                self.userNotification.onNext(UserNotification())
            })
            .flatMap{ _ -> Observable<Int> in
                self.juiceMaker.fruitStockObservable(of: fruit)
            }
            .map{String($0)}
            .retry(when: { _ in
                stepperValue
            })

        return updatedStock
    }
}

struct UserNotification {
    var title = "더 이상 줄일 수 없어요😰"
    var ok = "확인"
}
