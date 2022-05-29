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
            strawberryButtonTapped: self.strawberryJuiceButton?.rx.tap.asObservable(),
            peachButtonTapped: self.peachJuiceButton?.rx.tap.asObservable(),
            strawberryPeachButtonTapped: self.strawberryPeachJuiceButton?.rx.tap.asObservable(),
            pineappleButtonTapped: self.pineappleJuiceButton?.rx.tap.asObservable(),
            watermelonButtonTapped: self.watermelonJuiceButton?.rx.tap.asObservable(),
            watermelonPineappleButtonTapped: self.watermelonPineappleJuiceButton?.rx.tap.asObservable(),
            bananaButtonTapped: self.bananaJuiceButton?.rx.tap.asObservable())
        let output = juiceMakerViewModel.transfrom(input: input)
        
        output.strawberryStock
            .subscribe(onNext: {stock in
                self.strawberryStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.peachStock
            .subscribe(onNext: {stock in
                self.peachStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.pineappleStock
            .subscribe(onNext: {stock in
                self.pineappleStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.watermelonStock
            .subscribe(onNext: {stock in
                self.watermelonStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.bananaStock
            .subscribe(onNext: {stock in
                self.bananaStockLabel?.text = stock
            })
            .disposed(by: disposeBag)
        
        output.alertMessage
            .subscribe(onNext: {string in
                print(string)
        })
        .disposed(by: disposeBag)
        
        output.buttonSubscribe
            .subscribe()
            .disposed(by: disposeBag)
    }
    
}

