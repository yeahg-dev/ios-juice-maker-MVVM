//
//  FruitStockViewModel.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift

class FruitStockViewModel {
    
    private let juiceMaker = JuiceMaker()
    private let disposeBag = DisposeBag()
    
    let strawberryStockObservable = PublishSubject<String?>()
    let peachStockObservable = PublishSubject<String?>()
    let pineappleStockObservable = PublishSubject<String?>()
    let watermelonStockObservable = PublishSubject<String?>()
    let bananaStockObservable = PublishSubject<String?>()
    let notificationObservable = PublishSubject<FruitStockNotification>()
    
    var initialStrawberryStock: Int?
    var initialPeachStock: Int?
    var initialPineappleStock: Int?
    var initialWatermelonStock: Int?
    var initialBananaStock: Int?

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
        let notificationObservable: PublishSubject<FruitStockNotification>
    }
    
    func transform(input: Input) -> Output {
        // steppervalue 모델에 반영
        // 모델: 0 이상이면 현재개수 방출하는 Observable 리턴, 0이하면 오류 방출하는 Observable 리턴하는 메서드 구현
        // 뷰모델에서 모델이 방출하는 개수를 StockObservable에 onNext로 흘려보냄
        // 뷰컨에서 에러에대한 알럿 구현
        
        // 뷰컨트롤러에서 strawberryStepperValueObservable를 strawberryStepper?.rx.value.asObservable() 로 정의
        input.strawberryStepperValueObservable?
            .map({[weak self] stepperValue in
                self?.initialStrawberryStock ?? 0 + Int(stepperValue)
            })
            .flatMap({ newValue in
                self.juiceMaker.modifiedFruitStockObservable(of: .strawberry, with: newValue)
            })
            .map{String($0)}
            .debug()
            .subscribe(
                onNext: { stock in
                    self.strawberryStockObservable.onNext(stock)
                }, onError:{ [weak self] _ in
                    self?.notificationObservable.onNext(FruitStockNotification())
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
}

struct FruitStockNotification {
    var title = "더 이상 줄일 수 없어요"
    var ok = "확인"
}
