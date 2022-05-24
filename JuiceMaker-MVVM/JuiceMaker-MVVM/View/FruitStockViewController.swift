//
//  FruitStockViewController.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/21.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    // MARK: - Property
    
    private var fruitStockViewModel = FruitStockViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var input = FruitStockViewModel.Input(
        strawberryStepperValueObservable: self.strawberryStepper?.rx.value.asObservable(),
        peachStepperValueObservable: self.peachStepper?.rx.value.asObservable(),
        pineappeldStepperValueObservable: self.pineappleStepper?.rx.value.asObservable(),
        watermelonStepperValueObservable: self.watermelonStepper?.rx.value.asObservable(),
        bananaStepperValueObservable: self.bananaStepper?.rx.value.asObservable())
    
    private lazy var output = fruitStockViewModel.transform(input: input)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }
    
    // MARK: - bind
    
    func bindUI() {     
        self.output.notificationObservable?
            .subscribe { userNotification in
                let notification = userNotification.element
                print("\(String(describing: notification?.title))")
            }.disposed(by: disposeBag)
        
        self.output.strawberryStockObservable?
            .withUnretained(self)
            .subscribe(onNext: {(owner, stock) in
                self.strawberryStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        self.output.peachStockObservable?
            .withUnretained(self)
            .subscribe(onNext: { (owner, stock) in
                self.peachStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        self.output.pineappleStockObservable?
            .withUnretained(self)
            .subscribe(onNext: { (owner, stock) in
                self.pineappleStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        self.output.watermelonStockObservable?
            .withUnretained(self)
            .subscribe(onNext: { (owner, stock) in
                self.watermelonStockLabel?.text = stock
                
            })
            .disposed(by: disposeBag)
        
        self.output.bananaStockObservable?
            .withUnretained(self)
            .subscribe(onNext: { (owner, stock) in
                self.bananaStockLabel?.text = stock
                
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - @IBAction
    @IBAction func tappedDoneButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
