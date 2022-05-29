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
        let strawberryButtonTapped: Observable<Void>?
        let peachButtonTapped: Observable<Void>?
        let strawberryPeachButtonTapped: Observable<Void>?
        let pineappleButtonTapped: Observable<Void>?
        let watermelonButtonTapped: Observable<Void>?
        let watermelonPineappleButtonTapped: Observable<Void>?
        let bananaButtonTapped: Observable<Void>?
    }
    
    struct Output {
        let strawberryStock: PublishSubject<String>
        let peachStock: PublishSubject<String>
        let pineappleStock: PublishSubject<String>
        let watermelonStock: PublishSubject<String>
        let bananaStock: PublishSubject<String>
        let buttonSubscribe: Observable<Void>
        let alertMessage: PublishSubject<JuiceMakerUserNotification>
    }
    
    // MARK: - bindViewModel
    
    func transfrom(input: Input) -> Output {
        let strawberryStock = PublishSubject<String>()
        let peachStock = PublishSubject<String>()
        let pineappleStock = PublishSubject<String>()
        let watermelonStock = PublishSubject<String>()
        let bananaStock = PublishSubject<String>()
        
        let alertMessage = PublishSubject<JuiceMakerUserNotification>()
        
        let strawberryAction = input.strawberryButtonTapped?
            .flatMap({
                self.juiceMaker.makeJuice(StrawberryJuice())
            })
            .do(onNext: { juice in
                let notificaiton = JuiceMakerUserNotification(
                    title: UserNotification.orderSucces(of: juice),
                    message: UserNotification.successMessage.rawValue,
                    action: UserNotification.action.rawValue)
                alertMessage.onNext(notificaiton)
            }, onError: { error in
               let notification = JuiceMakerUserNotification(
                title: UserNotification.failureTitle.rawValue,
                message: nil,
                action: UserNotification.action.rawValue)
                alertMessage.onNext(notification)
            })
            .map({ _ in})
        
        let peachAction = input.peachButtonTapped?
                .flatMap({
                    self.juiceMaker.makeJuice(PeachJuice())
                })
                .do(onNext: { juice in
                    let notificaiton = JuiceMakerUserNotification(
                        title: UserNotification.orderSucces(of: juice),
                        message: UserNotification.successMessage.rawValue,
                        action: UserNotification.action.rawValue)
                    alertMessage.onNext(notificaiton)
                }, onError: { error in
                    let notification = JuiceMakerUserNotification(
                     title: UserNotification.failureTitle.rawValue,
                     message: nil,
                     action: UserNotification.action.rawValue)
                     alertMessage.onNext(notification)
                })
                .map({ _ in})
                    
        let strawberryPeachAction = input.strawberryPeachButtonTapped?
                .flatMap({
                    self.juiceMaker.makeJuice(StrawberryPeachJuice())
                })
                .do(onNext: { juice in
                    let notificaiton = JuiceMakerUserNotification(
                        title: UserNotification.orderSucces(of: juice),
                        message: UserNotification.successMessage.rawValue,
                        action: UserNotification.action.rawValue)
                    alertMessage.onNext(notificaiton)
                }, onError: { error in
                    let notification = JuiceMakerUserNotification(
                     title: UserNotification.failureTitle.rawValue,
                     message: nil,
                     action: UserNotification.action.rawValue)
                     alertMessage.onNext(notification)
                })
                .map({ _ in})
                                
        let pineappleAction = input.pineappleButtonTapped?
                .flatMap({
                    self.juiceMaker.makeJuice(PineappleJuice())
                })
                .do(onNext: { juice in
                    let notificaiton = JuiceMakerUserNotification(
                        title: UserNotification.orderSucces(of: juice),
                        message: UserNotification.successMessage.rawValue,
                        action: UserNotification.action.rawValue)
                    alertMessage.onNext(notificaiton)
                }, onError: { error in
                    let notification = JuiceMakerUserNotification(
                     title: UserNotification.failureTitle.rawValue,
                     message: nil,
                     action: UserNotification.action.rawValue)
                     alertMessage.onNext(notification)
                })
                .map({ _ in})
                    
        let watermelonAction = input.watermelonButtonTapped?
                .flatMap({
                    self.juiceMaker.makeJuice(WatermelonJuice())
                })
                .do(onNext: { juice in
                    let notificaiton = JuiceMakerUserNotification(
                        title: UserNotification.orderSucces(of: juice),
                        message: UserNotification.successMessage.rawValue,
                        action: UserNotification.action.rawValue)
                    alertMessage.onNext(notificaiton)
                }, onError: { error in
                    let notification = JuiceMakerUserNotification(
                     title: UserNotification.failureTitle.rawValue,
                     message: nil,
                     action: UserNotification.action.rawValue)
                     alertMessage.onNext(notification)
                })
                .map({ _ in})
                                                        
        let watermelonPineappleAction = input.watermelonPineappleButtonTapped?
                .flatMap({
                    self.juiceMaker.makeJuice(PineappleWatermelonJuice())
                })
                .do(onNext: { juice in
                    let notificaiton = JuiceMakerUserNotification(
                        title: UserNotification.orderSucces(of: juice),
                        message: UserNotification.successMessage.rawValue,
                        action: UserNotification.action.rawValue)
                    alertMessage.onNext(notificaiton)
                }, onError: { error in
                    let notification = JuiceMakerUserNotification(
                     title: UserNotification.failureTitle.rawValue,
                     message: nil,
                     action: UserNotification.action.rawValue)
                     alertMessage.onNext(notification)
                })
                .map({ _ in})
                                                                    
        let bananaAction = input.bananaButtonTapped?
                .flatMap({
                    self.juiceMaker.makeJuice(BananaJuice())
                })
                .do(onNext: { juice in
                    let notificaiton = JuiceMakerUserNotification(
                        title: UserNotification.orderSucces(of: juice),
                        message: UserNotification.successMessage.rawValue,
                        action: UserNotification.action.rawValue)
                    alertMessage.onNext(notificaiton)
                }, onError: { error in
                    let notification = JuiceMakerUserNotification(
                     title: UserNotification.failureTitle.rawValue,
                     message: nil,
                     action: UserNotification.action.rawValue)
                     alertMessage.onNext(notification)
                })
                .map({ _ in})
                    
        let buttonSubscribe = Observable.merge(input.viewWillAppear, strawberryAction!, peachAction!, strawberryPeachAction!, pineappleAction!, watermelonAction!, watermelonPineappleAction!, bananaAction!)
                    .do(onNext: { self.fruitStock(of: .strawberry)
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
                            }.dispose()})
        .retry()

        return Output(strawberryStock: strawberryStock,
                      peachStock: peachStock,
                      pineappleStock: pineappleStock,
                      watermelonStock: watermelonStock,
                      bananaStock: bananaStock,
                      buttonSubscribe: buttonSubscribe,
                      alertMessage: alertMessage)
    }
    
    private func fruitStock(of fruit: Fruit) -> Observable<String> {
        self.juiceMaker.fruitStockObservable(of: fruit).map{String($0)}
    }
    
    // MARK: - UserNotification
    
    enum UserNotification: String {
        
        case successTitile
        case successMessage = "Enjoy!😛"
        case failureTitle = "재료가 모자라요🥲"
        case action = "확인"
        
        static func orderSucces(of juice: FruitJuice?) -> String {
            "\(juice?.name ?? "") 나왔습니다"
        }
    }
    
}

struct JuiceMakerUserNotification {
    
    var title: String?
    var message: String?
    var action: String?
}
