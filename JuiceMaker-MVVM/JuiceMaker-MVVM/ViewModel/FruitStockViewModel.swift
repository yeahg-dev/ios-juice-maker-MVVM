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
    
    let strawberryStockObservable = PublishSubject<String?>()
    let peachStockObservable = PublishSubject<String?>()
    let pineappleStockObservable = PublishSubject<String?>()
    let watermelonStockObservable = PublishSubject<String?>()
    let bananaStockObservable = PublishSubject<String?>()
    let notificationObservable = PublishSubject<UserNotification>()
    
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
        let strawberryStockObservable: PublishSubject<String?>
        let peachStockObservable: PublishSubject<String?>
        let pineappleStockObservable: PublishSubject<String?>
        let watermelonStockObservable: PublishSubject<String?>
        let bananaStockObservable: PublishSubject<String?>
        let notificationObservable: PublishSubject<UserNotification>
    }
    
    // MARK: - bindViewModel
    func transform(input: Input) -> Output {

        input.strawberryStepperValueObservable?
            .map({[weak self] stepperValue in
                // FIXME: - initialStrawberryStock은 뷰컨트롤러에서 loadStock된 후 값이 생김
                (self?.initialStrawberryStock ?? 10) + Int(stepperValue)
            })
            .flatMap({ newValue in
                self.juiceMaker.modifiedFruitStockObservable(of: .strawberry, with: newValue)
            })
            .subscribe(
                onNext: { fruitStockModificationResult in
                    switch fruitStockModificationResult {
                    case .success:
                        self.juiceMaker.fruitStockObservable(of: .strawberry)
                            .map{String($0)}
                            .subscribe(onNext: { stock in
                                self.strawberryStockObservable.onNext(stock)
                            })
                            .disposed(by: self.disposeBag)
                    case .deficientFruitStockFailure  :
                        self.notificationObservable.onNext(UserNotification())
                    }
                })
            .disposed(by: disposeBag)
        
        input.peachStepperValueObservable?
            .map({[weak self] stepperValue in
                // FIXME: - initialStrawberryStock은 뷰컨트롤러에서 loadStock된 후 값이 생김
                (self?.initialPeachStock ?? 10) + Int(stepperValue)
            })
            .flatMap({ newValue in
                self.juiceMaker.modifiedFruitStockObservable(of: .peach, with: newValue)
            })
            .subscribe(
                onNext: { fruitStockModificationResult in
                    switch fruitStockModificationResult {
                    case .success:
                        self.juiceMaker.fruitStockObservable(of: .peach)
                            .map{String($0)}
                            .subscribe(onNext: { stock in
                                self.peachStockObservable.onNext(stock)
                            })
                            .disposed(by: self.disposeBag)
                    case .deficientFruitStockFailure  :
                        self.notificationObservable.onNext(UserNotification())
                    }
                })
            .disposed(by: disposeBag)
        
        input.pineappeldStepperValueObservable?
            .map({[weak self] stepperValue in
                // FIXME: - initialStrawberryStock은 뷰컨트롤러에서 loadStock된 후 값이 생김
                (self?.initialPineappleStock ?? 10) + Int(stepperValue)
            })
            .flatMap({ newValue in
                self.juiceMaker.modifiedFruitStockObservable(of: .pineapple, with: newValue)
            })
            .subscribe(
                onNext: { fruitStockModificationResult in
                    switch fruitStockModificationResult {
                    case .success:
                        self.juiceMaker.fruitStockObservable(of: .pineapple)
                            .map{String($0)}
                            .subscribe(onNext: { stock in
                                self.pineappleStockObservable.onNext(stock)
                            })
                            .disposed(by: self.disposeBag)
                    case .deficientFruitStockFailure  :
                        self.notificationObservable.onNext(UserNotification())
                    }
                })
            .disposed(by: disposeBag)
        
        input.watermelonStepperValueObservable?
            .map({[weak self] stepperValue in
                // FIXME: - initialStrawberryStock은 뷰컨트롤러에서 loadStock된 후 값이 생김
                (self?.initialWatermelonStock ?? 10) + Int(stepperValue)
            })
            .flatMap({ newValue in
                self.juiceMaker.modifiedFruitStockObservable(of: .watermelon, with: newValue)
            })
            .subscribe(
                onNext: { fruitStockModificationResult in
                    switch fruitStockModificationResult {
                    case .success:
                        self.juiceMaker.fruitStockObservable(of: .watermelon)
                            .map{String($0)}
                            .subscribe(onNext: { stock in
                                self.watermelonStockObservable.onNext(stock)
                            })
                            .disposed(by: self.disposeBag)
                    case .deficientFruitStockFailure  :
                        self.notificationObservable.onNext(UserNotification())
                    }
                })
            .disposed(by: disposeBag)
        
        input.bananaStepperValueObservable?
            .map({[weak self] stepperValue in
                // FIXME: - initialStrawberryStock은 뷰컨트롤러에서 loadStock된 후 값이 생김
                (self?.initialBananaStock ?? 10) + Int(stepperValue)
            })
            .flatMap({ newValue in
                self.juiceMaker.modifiedFruitStockObservable(of: .banana, with: newValue)
            })
            .subscribe(
                onNext: { fruitStockModificationResult in
                    switch fruitStockModificationResult {
                    case .success:
                        self.juiceMaker.fruitStockObservable(of: .banana)
                            .map{String($0)}
                            .subscribe(onNext: { stock in
                                self.bananaStockObservable.onNext(stock)
                            })
                            .disposed(by: self.disposeBag)
                    case .deficientFruitStockFailure  :
                        self.notificationObservable.onNext(UserNotification())
                    }
                })
            .disposed(by: disposeBag)
        
        return Output(strawberryStockObservable: strawberryStockObservable,
                      peachStockObservable: peachStockObservable,
                      pineappleStockObservable: pineappleStockObservable,
                      watermelonStockObservable: watermelonStockObservable,
                      bananaStockObservable: bananaStockObservable,
                      notificationObservable: notificationObservable)
    }
    
    func loadStock() {
        juiceMaker.fruitStockObservable(of: .strawberry)
            .map{String($0)}
            .subscribe(onNext: {[weak self] stock in
                self?.strawberryStockObservable.onNext(stock)
                self?.initialStrawberryStock = Int(stock)!
            })
            .disposed(by: disposeBag)
        
        juiceMaker.fruitStockObservable(of: .peach)
            .map{String($0)}
            .subscribe(onNext: {[weak self] stock in
                self?.peachStockObservable.onNext(stock)
                self?.initialStrawberryStock = Int(stock)!
            })
            .disposed(by: disposeBag)
        
        juiceMaker.fruitStockObservable(of: .pineapple)
            .map{String($0)}
            .subscribe(onNext: {[weak self] stock in
                self?.pineappleStockObservable.onNext(stock)
                self?.initialStrawberryStock = Int(stock)!
            })
            .disposed(by: disposeBag)
        
        juiceMaker.fruitStockObservable(of: .watermelon)
            .map{String($0)}
            .subscribe(onNext: {[weak self] stock in
                self?.watermelonStockObservable.onNext(stock)
                self?.initialStrawberryStock = Int(stock)!
            })
            .disposed(by: disposeBag)
        
        juiceMaker.fruitStockObservable(of: .banana)
            .map{String($0)}
            .subscribe(onNext: {[weak self] stock in
                self?.bananaStockObservable.onNext(stock)
                self?.initialStrawberryStock = Int(stock)!
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UserNotification
    
    struct UserNotification {
        var title = "더 이상 줄일 수 없어요"
        var ok = "확인"
    }
    
}

