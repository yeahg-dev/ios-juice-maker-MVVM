//
//  ViewController.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/19.
//

import UIKit
import RxSwift

class JuiceMakerViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var strawberryStockLabel: UILabel?
    @IBOutlet weak var peachStockLabel: UILabel?
    @IBOutlet weak var pineappleStockLabel: UILabel?
    @IBOutlet weak var watermelonStockLabel: UILabel?
    @IBOutlet weak var bananaStockLabel: UILabel?
    
    // MARK: - Property
    
    private let juiceMakerViewModel = JuiceMakerViewModel()
    
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadFruitStock()
    }

    // MARK: - bind UI
    
    private func loadFruitStock() {
        Fruit.allCases.forEach { fruit in
            loadStock(of: fruit)
        }
    }
    
    private func loadStock(of fruit: Fruit) {
        var label: UILabel?
        switch fruit {
        case .strawberry:
            label = self.strawberryStockLabel
        case .peach:
            label = self.peachStockLabel
        case .banana:
            label = self.bananaStockLabel
        case .pineapple:
            label = self.pineappleStockLabel
        case .watermelon:
            label = self.watermelonStockLabel
        }
        
        juiceMakerViewModel.fruitStockObservable(of: .strawberry)
            .map{String($0)}
            .subscribe(onNext: { stock in
                label?.text = stock
            }).disposed(by: disposeBag)
    }

}

