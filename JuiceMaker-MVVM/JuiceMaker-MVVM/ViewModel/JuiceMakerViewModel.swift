//
//  JuiceMakerViewModel.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift

struct JuiceMakerViewModel {
    
    // MARK: - Property
    
    private let juiceMaker = JuiceMaker()
    private let disposeBag = DisposeBag()
    
    // MARK: - Input/Output
    
    struct Input {
        let juiceOrder: PublishSubject<FruitJuice>
    }
    
    struct Output {
        let orderSuccess: BehaviorSubject<Bool>
        let alertMessage: BehaviorSubject<String>
    }
    
    // MARK: - bindViewModel
    
    func fruitStockObservable(of fruit: Fruit) -> Observable<Int> {
        return juiceMaker.fruitStockObservable(of: fruit)
    }
    
    func transfrom(input: Input) -> Output {
        let orderSuccess = BehaviorSubject<Bool>(value: true)
        let alertMessage = BehaviorSubject<String>(value: "")
        
        input.juiceOrder.map { fruitJuice in
            self.juiceMaker.makeJuice(fruitJuice)}
        .subscribe(onNext: {juiceObservable in
            juiceObservable
                .subscribe(onNext: { juice in
                    if juice != nil {
                        orderSuccess.onNext(true)
                        alertMessage.onNext(UserNotification.orderSucces(of: juice))
                        print("💖\(String(describing: juice))")
                    } else {
                        orderSuccess.onNext(false)
                        alertMessage.onNext(UserNotification.orderFailure.rawValue)
                        print("👻재료 모자람")
                    }})
                .disposed(by: disposeBag)
        })
        .disposed(by: disposeBag)
        
        return Output(orderSuccess: orderSuccess, alertMessage: alertMessage)
    }
    
    // MARK: - UserNotification
    
    enum UserNotification: String {
        
        case orderSuccess
        case orderFailure = "재료가 모자라요🥲"
        
        static func orderSucces(of juice: FruitJuice?) -> String {
            "\(juice?.name ?? "") 나왔습니다"
        }
    }
}
