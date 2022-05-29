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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }
    
    // MARK: - bind
    
    private func bindUI() {
        let input = FruitStockViewModel.Input(
            strawberryStepperValueObservable: self.strawberryStepper?.rx.value.asObservable(),
            peachStepperValueObservable: self.peachStepper?.rx.value.asObservable(),
            pineappeldStepperValueObservable: self.pineappleStepper?.rx.value.asObservable(),
            watermelonStepperValueObservable: self.watermelonStepper?.rx.value.asObservable(),
            bananaStepperValueObservable: self.bananaStepper?.rx.value.asObservable())
        
        let output = fruitStockViewModel.transform(input: input)
        
        output.notificationObservable?
            .subscribe { userNotification in
                let notification = userNotification.element
                self.presentAlert(title: notification?.title, action: notification?.ok)
            }.disposed(by: disposeBag)
        
        output.strawberryStockObservable?
            .withUnretained(self)
            .subscribe(onNext: {(owner, stock) in
                self.strawberryStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.peachStockObservable?
            .withUnretained(self)
            .subscribe(onNext: { (owner, stock) in
                self.peachStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.pineappleStockObservable?
            .withUnretained(self)
            .subscribe(onNext: { (owner, stock) in
                self.pineappleStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.watermelonStockObservable?
            .withUnretained(self)
            .subscribe(onNext: { (owner, stock) in
                self.watermelonStockLabel?.text = stock
                
            })
            .disposed(by: disposeBag)
        
        output.bananaStockObservable?
            .withUnretained(self)
            .subscribe(onNext: { (owner, stock) in
                self.bananaStockLabel?.text = stock
                
            })
            .disposed(by: disposeBag)
    }
    
    private func presentAlert(title: String?, action: String?) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: action, style: .default, handler: nil)
        alertController.addAction(OkAction)
        
        self.present(alertController, animated: true)
    }
    
    // MARK: - @IBAction
    @IBAction func tappedDoneButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
