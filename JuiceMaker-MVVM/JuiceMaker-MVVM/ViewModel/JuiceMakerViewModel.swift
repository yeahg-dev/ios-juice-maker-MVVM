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
        let viewWillAppear: Observable<Void>
        let juiceOrder: PublishSubject<FruitJuice>
    }
    
    struct Output {
        let strawberryStock: PublishSubject<String>
        let peachStock: PublishSubject<String>
        let pineappleStock: PublishSubject<String>
        let watermelonStock: PublishSubject<String>
        let bananaStock: PublishSubject<String>
        let alertMessage: BehaviorSubject<String>
    }
    
    // MARK: - bindViewModel
    
    func transfrom(input: Input) -> Output {
        let strawberryStock = PublishSubject<String>()
        let peachStock = PublishSubject<String>()
        let pineappleStock = PublishSubject<String>()
        let watermelonStock = PublishSubject<String>()
        let bananaStock = PublishSubject<String>()
        let alertMessage = BehaviorSubject<String>(value: "")
        
        input.viewWillAppear.subscribe(onNext:{
            self.fruitStock(of: .strawberry)
                .bind{ stock in
                    strawberryStock.onNext(stock)
                }.dispose()
            self.fruitStock(of: .peach)
                .bind{ stock in
                    peachStock.onNext(stock)
                }.dispose()
            self.fruitStock(of: .pineapple)
                .bind{ stock in
                    pineappleStock.onNext(stock)
                }.dispose()
            self.fruitStock(of: .watermelon)
                .bind{ stock in
                    watermelonStock.onNext(stock)
                }.dispose()
            self.fruitStock(of: .banana)
                .bind{ stock in
                    bananaStock.onNext(stock)
                }.dispose()
        }).disposed(by: disposeBag)
        
        input.juiceOrder
            .map { fruitJuice in
            self.juiceMaker.makeJuice(fruitJuice)}
        .subscribe(onNext: {juiceObservable in
            juiceObservable
                .subscribe(onNext: { juice in
                    if juice != nil {
                        self.fruitStock(of: .strawberry)
                            .bind{ stock in
                                strawberryStock.onNext(stock)
                            }.dispose()
                        self.fruitStock(of: .peach)
                            .bind{ stock in
                                peachStock.onNext(stock)
                            }.dispose()
                        self.fruitStock(of: .pineapple)
                            .bind{ stock in
                                pineappleStock.onNext(stock)
                            }.dispose()
                        self.fruitStock(of: .watermelon)
                            .bind{ stock in
                                watermelonStock.onNext(stock)
                            }.dispose()
                        self.fruitStock(of: .banana)
                            .bind{ stock in
                                bananaStock.onNext(stock)
                            }.dispose()
                    } else {
                        alertMessage.onNext(UserNotification.orderFailure.rawValue)
                        print("👻재료 모자람")
                    }})
                .disposed(by: disposeBag)
        })
        .disposed(by: disposeBag)
        
        return Output(strawberryStock: strawberryStock,
                      peachStock: peachStock,
                      pineappleStock: pineappleStock,
                      watermelonStock: watermelonStock,
                      bananaStock: bananaStock,
                      alertMessage: alertMessage)
    }
    
    private func fruitStock(of fruit: Fruit) -> Observable<String> {
        self.juiceMaker.fruitStockObservable(of: fruit).map{String($0)}
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
