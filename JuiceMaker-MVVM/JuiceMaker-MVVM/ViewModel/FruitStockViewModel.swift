//
//  FruitStockViewModel.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import Foundation
import RxSwift

struct FruitStockViewModel {
    
    private let juiceMaker = JuiceMaker()
    private let disposeBag = DisposeBag()
    
    let strawberryStockObservable = PublishSubject<Int>()
    let peachStockObservable = PublishSubject<Int>()
    let pineappleStockObservable = PublishSubject<Int>()
    let watermelonStockObservable = PublishSubject<Int>()
    let bananaStockObservable = PublishSubject<Int>()
    
    struct Input {
        
    }
    
    struct Output {
        let strawberryStockObservable: Observable<String?>
        let peachStockObservable: Observable<String?>
        let pineappleStockObservable: Observable<String?>
        let watermelonStockObservable: Observable<String?>
        let bananaStockObservable: Observable<String?>
    }
    
    func transform() -> Output {
        
        return Output(strawberryStockObservable: strawberryStockObservable.map{String($0)},
                      peachStockObservable: peachStockObservable.map{String($0)},
                      pineappleStockObservable: pineappleStockObservable.map{String($0)},
                      watermelonStockObservable: watermelonStockObservable.map{String($0)},
                      bananaStockObservable: bananaStockObservable.map{String($0)})
    }
    
    func loadStock() {
        juiceMaker.fruitStockObservable(of: .strawberry)
            .subscribe(onNext: {stock in strawberryStockObservable.onNext(stock)})
            .disposed(by: disposeBag)
        
        juiceMaker.fruitStockObservable(of: .peach)
            .subscribe(onNext: {stock in peachStockObservable.onNext(stock)})
            .disposed(by: disposeBag)
        
        juiceMaker.fruitStockObservable(of: .pineapple)
            .subscribe(onNext: {stock in pineappleStockObservable.onNext(stock)})
            .disposed(by: disposeBag)
        
        juiceMaker.fruitStockObservable(of: .watermelon)
            .subscribe(onNext: {stock in watermelonStockObservable.onNext(stock)})
            .disposed(by: disposeBag)
        
        juiceMaker.fruitStockObservable(of: .banana)
            .subscribe(onNext: {stock in bananaStockObservable.onNext(stock)})
            .disposed(by: disposeBag)
    }
    
}
