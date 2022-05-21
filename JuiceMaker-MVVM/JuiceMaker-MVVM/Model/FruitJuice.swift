//
//  FruitJuice.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/20.
//

import Foundation

protocol FruitJuice {
    
    var name: String { get }
    
    var ingredients: [Fruit: Int] { get }
    
}

struct StrawberryJuice: FruitJuice {
    
    var name: String {
        return "딸기 쥬스"
    }
    
    var ingredients: [Fruit: Int] {
        return [Fruit.strawberry: 7]
    }
    
}

struct PeachJuice: FruitJuice {
    
    var name: String {
        return "복숭아 쥬스"
    }
    
    var ingredients: [Fruit: Int] {
        return [Fruit.peach: 3]
    }
    
}

struct StrawberryPeachJuice: FruitJuice {
    
    var name: String {
        return "딸복 쥬스"
    }
    
    var ingredients: [Fruit: Int] {
        return [Fruit.strawberry: 5, Fruit.peach: 2]
    }
    
}

struct WatermelonJuice: FruitJuice {
    
    var name: String {
        return "수박 쥬스"
    }
    
    var ingredients: [Fruit: Int] {
        return [Fruit.watermelon: 1]
    }
    
}

struct PineappleJuice: FruitJuice {
    
    var name: String {
        return "파인애플 쥬스"
    }
    
    var ingredients: [Fruit: Int] {
        return [Fruit.pineapple: 1]
    }
    
}

struct PineappleWatermelonJuice: FruitJuice {
    
    var name: String {
        return "수파 쥬스"
    }
    
    var ingredients: [Fruit: Int] {
        return [Fruit.watermelon: 1, Fruit.pineapple: 1]
    }
    
}

struct BananaJuice: FruitJuice {
    
    var name: String {
        return "바나나 쥬스"
    }
    
    var ingredients: [Fruit: Int] {
        return [Fruit.banana: 5]
    }
    
}

