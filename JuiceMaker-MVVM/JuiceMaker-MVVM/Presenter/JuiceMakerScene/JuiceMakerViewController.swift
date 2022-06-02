//
//  ViewController.swift
//  JuiceMaker-MVVM
//
//  Created by 1 on 2022/05/19.
//

import UIKit
import RxSwift
import RxCocoa

class JuiceMakerViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var strawberryStockLabel: UILabel?
    @IBOutlet weak var peachStockLabel: UILabel?
    @IBOutlet weak var pineappleStockLabel: UILabel?
    @IBOutlet weak var watermelonStockLabel: UILabel?
    @IBOutlet weak var bananaStockLabel: UILabel?
    
    @IBOutlet weak var strawberryPeachJuiceButton: UIButton?
    @IBOutlet weak var strawberryJuiceButton: UIButton?
    @IBOutlet weak var peachJuiceButton: UIButton?
    @IBOutlet weak var watermelonPineappleJuiceButton: UIButton?
    @IBOutlet weak var pineappleJuiceButton: UIButton?
    @IBOutlet weak var watermelonJuiceButton: UIButton?
    @IBOutlet weak var bananaJuiceButton: UIButton?
    
    // MARK: - Property
    
    private let juiceMakerViewModel = JuiceMakerViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }
    
    // MARK: - bind UI
    
    private func bindUI() {
        
        let input = JuiceMakerViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map{_ in},
            presentedViewDismissed: self.rx.methodInvoked(#selector(JuiceMakerViewController.presentedViewControllerDidDismissed)).map{_ in}.debug(),
            strawberryButtonTapped: self.strawberryJuiceButton?.rx.tap.asObservable(),
            peachButtonTapped: self.peachJuiceButton?.rx.tap.asObservable(),
            strawberryPeachButtonTapped: self.strawberryPeachJuiceButton?.rx.tap.asObservable(),
            pineappleButtonTapped: self.pineappleJuiceButton?.rx.tap.asObservable(),
            watermelonButtonTapped: self.watermelonJuiceButton?.rx.tap.asObservable(),
            watermelonPineappleButtonTapped: self.watermelonPineappleJuiceButton?.rx.tap.asObservable(),
            bananaButtonTapped: self.bananaJuiceButton?.rx.tap.asObservable())
        let output = juiceMakerViewModel.transfrom(input: input)
        
        output.strawberryStock
            .withUnretained(self)
            .subscribe(onNext: { (self, stock) in
                self.strawberryStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.peachStock
            .withUnretained(self)
            .subscribe(onNext: { (self, stock) in
                self.peachStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.pineappleStock
            .withUnretained(self)
            .subscribe(onNext: { (self, stock) in
                self.pineappleStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.watermelonStock
            .withUnretained(self)
            .subscribe(onNext: { (self, stock) in
                self.watermelonStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.bananaStock
            .subscribe(onNext: {stock in
                self.bananaStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.alertMessage
            .withUnretained(self)
            .subscribe(onNext: { (self, notifiactioin) in
                self.presentAlert(title: notifiactioin.title, message: notifiactioin.message, action: notifiactioin.action)
        })
        .disposed(by: disposeBag)

    }
    
    private func presentAlert(title: String?, message: String?, action: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: action, style: .default, handler: nil)
        alertController.addAction(OkAction)
        
        self.present(alertController, animated: true)
    }
    
    @objc dynamic private func presentedViewControllerDidDismissed() {
        return
    }
}

protocol FruitStockViewControllerDelegate {
    
    func didDismiss(_: UIViewController)
}

extension JuiceMakerViewController: FruitStockViewControllerDelegate {
    
    
    func didDismiss(_: UIViewController) {
        self.presentedViewControllerDidDismissed()
    }
    
}
