//
//  FruitRepository.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/20.
//

import Foundation
import RxSwift

class FruitRepository {
    
    static let shared = FruitRepository(defaultFruitStock: 10)
    
    var storage: [Fruit: Int] = [:]
    
    init(defaultFruitStock: Int) {
        for fruit in Fruit.allCases {
            storage.updateValue(defaultFruitStock, forKey: fruit)
        }
    }
    
    func create(_ fruit: Fruit) {
        let latestStock = storage[fruit] ?? 0
        self.storage.updateValue(latestStock + 1, forKey: fruit)
    }
    
    func read(_ fruit: Fruit) -> Observable<Int> {
        let availableStock = self.storage[fruit]
        
        let observable =  Observable.just(availableStock)
            .filter{$0 != nil}
            .map{$0!}
        
        return observable
    }
    
    func update(_ fruit: Fruit, by amount: Int) {
        let latestStock = storage[fruit] ?? 0
        let updatingStock = latestStock + amount
        self.storage.updateValue(updatingStock, forKey: fruit)
    }
    
}