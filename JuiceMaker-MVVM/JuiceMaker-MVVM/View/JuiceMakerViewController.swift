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
    
    private lazy var input = JuiceMakerViewModel.Input(juiceOrder: PublishSubject<FruitJuice>())
    private lazy var output = juiceMakerViewModel.transfrom(input: input)
    
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadFruitStock()
        self.bindUI()
    }
    
    // MARK: - bind UI
    
    private func bindUI() {
        output.orderSuccess.subscribe(onNext: { [weak self] result in
            self?.loadFruitStock()
        }).disposed(by: disposeBag)
        
        output.alertMessage.subscribe(onNext: {string in
            //TODO: - Alert 구현
        }).disposed(by: disposeBag)
    }
    
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
        
        juiceMakerViewModel.fruitStockObservable(of: fruit)
            .map{String($0)}
            .subscribe(onNext: { stock in
                label?.text = stock
            }).disposed(by: disposeBag)
    }
    
    // MARK: - @IBAction
    @IBAction func orderStrawberryPeachJuice(_ sender: UIButton) {
        self.input.juiceOrder.onNext(StrawberryPeachJuice())
    }
    
    @IBAction func orderStrawberryJuice(_ sender: UIButton) {
        self.input.juiceOrder.onNext(StrawberryJuice())
    }
    
    @IBAction func orderPeachJuice(_ sender: UIButton) {
        self.input.juiceOrder.onNext(PeachJuice())
    }
    
    @IBAction func orderWatermelonPineappleJuice(_ sender: UIButton) {
        self.input.juiceOrder.onNext(PineappleWatermelonJuice())
    }
    
    @IBAction func orderPineappleJuice(_ sender: UIButton) {
        self.input.juiceOrder.onNext(PineappleJuice())
    }
    
    @IBAction func orderWatermelonJuice(_ sender: UIButton) {
        self.input.juiceOrder.onNext(WatermelonJuice())
    }
    
    @IBAction func orderBananaJuice(_ sender: UIButton) {
        self.input.juiceOrder.onNext(BananaJuice())
    }
    
}

