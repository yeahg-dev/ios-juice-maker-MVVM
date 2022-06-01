//
//  JuiceMakerViewModel.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift
import RxCocoa

struct JuiceMakerViewModel {
    
    // MARK: - Property
    
    private let juiceMaker = JuiceMaker()
    
    // MARK: - Input/Output
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let presentedViewDismissed: Observable<Void>
        let strawberryButtonTapped: Observable<Void>?
        let peachButtonTapped: Observable<Void>?
        let strawberryPeachButtonTapped: Observable<Void>?
        let pineappleButtonTapped: Observable<Void>?
        let watermelonButtonTapped: Observable<Void>?
        let watermelonPineappleButtonTapped: Observable<Void>?
        let bananaButtonTapped: Observable<Void>?
    }
    
    struct Output {
        let strawberryStock: Observable<String>
        let peachStock: Observable<String>
        let pineappleStock: Observable<String>
        let watermelonStock: Observable<String>
        let bananaStock: Observable<String>
        let alertMessage: PublishSubject<JuiceMakerUserNotification>
    }
    
    // MARK: - bindViewModel
    
    func transfrom(input: Input) -> Output {
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
            .retry()
        
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
                .retry()
                                
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
                .retry()
                    
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
                .retry()
                                                        
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
                .retry()
                                                                    
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
                .retry()

        let strawberryStock = Observable.merge(input.viewWillAppear, input.presentedViewDismissed, strawberryAction!, strawberryPeachAction!)
            .flatMap { _ in
                self.fruitStock(of: .strawberry)
            }
        
        let peachStock = Observable.merge(input.viewWillAppear, input.presentedViewDismissed, peachAction!, strawberryPeachAction!)
            .flatMap { _ in
                self.fruitStock(of: .peach)
            }
        
        let pineappleStock = Observable.merge(input.viewWillAppear, input.presentedViewDismissed, pineappleAction!, watermelonPineappleAction!)
            .flatMap { _ in
                self.fruitStock(of: .pineapple)
            }
        
        let watermelonStock = Observable.merge(input.viewWillAppear, input.presentedViewDismissed, watermelonAction!, watermelonPineappleAction!)
            .flatMap { _ in
                self.fruitStock(of: .watermelon)
            }
        
        let bananaStock = Observable.merge(input.viewWillAppear, input.presentedViewDismissed, bananaAction!)
            .flatMap { _ in
                self.fruitStock(of: .banana)
            }
        
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
