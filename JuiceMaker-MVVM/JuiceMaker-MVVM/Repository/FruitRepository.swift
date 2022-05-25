//
//  FruitRepository.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/20.
//

import Foundation
import RxSwift

final class FruitRepository {
    
    // MARK: - Property
    
    static let shared = FruitRepository(defaultFruitStock: 10)
    
    private var storage: [Fruit: Int] = [:]
    
    // MARK: - Method
    
    init(defaultFruitStock: Int) {
        for fruit in Fruit.allCases {
            storage.updateValue(defaultFruitStock, forKey: fruit)
        }
    }
    
    func create(_ fruit: Fruit) {
        guard let _ = self.storage[fruit] else {
            self.storage.updateValue( 1, forKey: fruit)
            return
        }
    }
    
    func read(_ fruit: Fruit) -> Observable<Int> {
        let latestStock = self.storage[fruit]
        
        let observable =  Observable.just(latestStock)
            .filter{$0 != nil}
            .map{$0!}
        
        return observable
    }
    
    func update(_ fruit: Fruit, with newValue: Int) -> Observable<Bool> {
        self.storage.updateValue(newValue, forKey: fruit)
        return Observable<Bool>.just(true)
    }
    
    func decrease(_ fruit: Fruit, by amount: Int) {
        let latestStock = storage[fruit] ?? 0
        let updatingStock = latestStock - amount
        self.storage.updateValue(updatingStock, forKey: fruit)
    }

}

