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
    
}
