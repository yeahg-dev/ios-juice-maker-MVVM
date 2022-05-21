//
//  FruitStockViewController.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import UIKit
import RxSwift

class FruitStockViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var strawberryStockLabel: UILabel?
    @IBOutlet weak var peachStockLabel: UILabel?
    @IBOutlet weak var pineappleStockLabel: UILabel?
    @IBOutlet weak var watermelonStockLabel: UILabel?
    @IBOutlet weak var bananaStockLabel: UILabel?
    
    @IBOutlet weak var strawberryStepper: UIStepper?
    @IBOutlet weak var peachStepper: UIStepper?
    @IBOutlet weak var pineappleStepper: UIStepper?
    @IBOutlet weak var watermelonStepper: UIStepper?
    @IBOutlet weak var bananaStepper: UIStepper?
    
    private let fruitStockViewModel = FruitStockViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var output = fruitStockViewModel.transform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        fruitStockViewModel.loadStock()
    }
  
    func bindUI() {
        self.output.strawberryStockObservable
            .subscribe(onNext: {[weak self] stock in
                self?.strawberryStockLabel?.text = stock})
            .disposed(by: disposeBag)
        
        self.output.peachStockObservable
            .subscribe(onNext: {[weak self] stock in
                self?.peachStockLabel?.text = stock})
            .disposed(by: disposeBag)
        
        self.output.pineappleStockObservable
            .subscribe(onNext: {[weak self] stock in
                self?.pineappleStockLabel?.text = stock})
            .disposed(by: disposeBag)
        
        self.output.watermelonStockObservable
            .subscribe(onNext: {[weak self] stock in
                self?.watermelonStockLabel?.text = stock})
            .disposed(by: disposeBag)
        
        self.output.bananaStockObservable
            .subscribe(onNext: {[weak self] stock in
                self?.bananaStockLabel?.text = stock})
            .disposed(by: disposeBag)
    }
    
    @IBAction func tappedDoneButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
