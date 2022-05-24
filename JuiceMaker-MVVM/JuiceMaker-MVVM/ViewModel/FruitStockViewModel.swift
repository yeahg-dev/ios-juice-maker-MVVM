//
//  FruitStockViewModel.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift

class FruitStockViewModel {
    
    // MARK: - Property
    
    private let juiceMaker = JuiceMaker()
    private let disposeBag = DisposeBag()
    
    // TODO: - 삭제
    var initialStrawberryStock: Int?
    var initialPeachStock: Int?
    var initialPineappleStock: Int?
    var initialWatermelonStock: Int?
    var initialBananaStock: Int?
    
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
        let userNotificationObservable = PublishSubject<UserNotification>()
        
        let strawberryStockModificationObservable = input.strawberryStepperValueObservable?
            .map{Int($0)}
            .map({ [weak self] stepperValue in
                stepperValue + (self?.initialStrawberryStock ?? 10)
            })
            .flatMap({ stock in
                self.juiceMaker.modifiedFruitStockObservable(of: .strawberry, with: stock)
            })
            .share(replay: 1)
            
        let strawberryStockObservable = strawberryStockModificationObservable?
            .do(onNext: { modificationResult in
                if modificationResult == .deficientFruitStockFailure {
                    userNotificationObservable.onNext(UserNotification())
                }
            })
            .filter({ stockModificationResult in
                stockModificationResult == FruitStockModification.success
            })
            .flatMap{ _ -> Observable<Int> in
                self.juiceMaker.fruitStockObservable(of: .strawberry)
            }
            .map{ stock in
                String(stock) }
        
        let peachStockModificationObservable = input.peachStepperValueObservable?
            .map{Int($0)}
            .map({ [weak self] stepperValue in
                stepperValue + (self?.initialPeachStock ?? 10)
            })
            .flatMap({ stock in
                self.juiceMaker.modifiedFruitStockObservable(of: .peach, with: stock)
            })
            .share(replay: 1)
            
        let peachStockObservable = peachStockModificationObservable?
            .do(onNext: { modificationResult in
                if modificationResult == .deficientFruitStockFailure {
                    userNotificationObservable.onNext(UserNotification())
                }
            })
            .filter({ stockModificationResult in
                stockModificationResult == FruitStockModification.success
            })
            .flatMap{ _ -> Observable<Int> in
                self.juiceMaker.fruitStockObservable(of: .peach)
            }
            .map{ stock in
                String(stock) }
        
        let pineappleStockModificationObservable = input.pineappeldStepperValueObservable?
            .map{Int($0)}
            .map({ [weak self] stepperValue in
                stepperValue + (self?.initialPineappleStock ?? 10)
            })
            .flatMap({ stock in
                self.juiceMaker.modifiedFruitStockObservable(of: .pineapple, with: stock)
            })
            .share(replay: 1)
        
        let pineappleStockObservable = pineappleStockModificationObservable?
            .do(onNext: { modificationResult in
                if modificationResult == .deficientFruitStockFailure {
                    userNotificationObservable.onNext(UserNotification())
                }
            })
            .filter({ stockModificationResult in
                stockModificationResult == FruitStockModification.success
            })
            .flatMap{ _ -> Observable<Int> in
                self.juiceMaker.fruitStockObservable(of: .pineapple)
            }
            .map{ stock in
                String(stock) }
        
        let watermelonStockModificationObservable = input.watermelonStepperValueObservable?
            .map{Int($0)}
            .map({ [weak self] stepperValue in
                stepperValue + (self?.initialWatermelonStock ?? 10)
            })
            .flatMap({ stock in
                self.juiceMaker.modifiedFruitStockObservable(of: .watermelon, with: stock)
            })
            .share(replay: 1)
        
        let watermelonStockObservable = watermelonStockModificationObservable?
            .do(onNext: { modificationResult in
                if modificationResult == .deficientFruitStockFailure {
                    userNotificationObservable.onNext(UserNotification())
                }
            })
            .filter({ stockModificationResult in
                stockModificationResult == FruitStockModification.success
            })
            .flatMap{ _ -> Observable<Int> in
                self.juiceMaker.fruitStockObservable(of: .watermelon)
            }
            .map{ stock in
                String(stock) }
        
        let bananaStockModificationObservable = input.bananaStepperValueObservable?
            .map{Int($0)}
            .map({ [weak self] stepperValue in
                stepperValue + (self?.initialBananaStock ?? 10)
            })
            .flatMap({ stock in
                self.juiceMaker.modifiedFruitStockObservable(of: .banana, with: stock)
            })
            .share(replay: 1)
        
        let bananaStockObservable = bananaStockModificationObservable?
            .do(onNext: { modificationResult in
                if modificationResult == .deficientFruitStockFailure {
                    userNotificationObservable.onNext(UserNotification())
                }
            })
            .filter({ stockModificationResult in
                stockModificationResult == FruitStockModification.success
            })
            .flatMap{ _ -> Observable<Int> in
                self.juiceMaker.fruitStockObservable(of: .banana)
            }
            .map{ stock in
                String(stock) }
     

        return Output(strawberryStockObservable: strawberryStockObservable,
                      peachStockObservable: peachStockObservable,
                      pineappleStockObservable: pineappleStockObservable,
                      watermelonStockObservable: watermelonStockObservable,
                      bananaStockObservable: bananaStockObservable,
                      notificationObservable: userNotificationObservable)
    }
  
}

struct UserNotification {
    var title = "더 이상 줄일 수 없어요"
    var ok = "확인"
}
