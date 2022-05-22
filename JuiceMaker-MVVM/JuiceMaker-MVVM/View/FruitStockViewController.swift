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
    
    private var fruitStockViewModel = FruitStockViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var input = FruitStockViewModel.Input(
        strawberryStepperValueObservable: self.strawberryStepper?.rx.value.asObservable(),
        peachStepperValueObservable: self.peachStepper?.rx.value.asObservable(),
        pineappeldStepperValueObservable: self.pineappleStepper?.rx.value.asObservable(),
        watermelonStepperValueObservable: self.watermelonStepper?.rx.value.asObservable(),
        bananaStepperValueObservable: self.bananaStepper?.rx.value.asObservable())
    
    private lazy var output = fruitStockViewModel.transform(input: input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
        self.fruitStockViewModel.loadStock()
        self.bindViewModel()
    }
    
    func bindViewModel() {
        
            // steppervalue 모델에 반영
            // 모델: 0 이상이면 현재개수 방출하는 Observable 리턴, 0이하면 오류 방출하는 Observable 리턴하는 메서드 구현
            // 뷰모델에서 모델이 방출하는 개수를 StockObservable에 onNext로 흘려보냄
            // 뷰컨에서 에러에대한 알럿 구현
        self.output.strawberryStockObservable
            .subscribe(onNext:{ stock in
                self.strawberryStockLabel?.text = stock
            }).disposed(by: disposeBag)
    }
  
    func bindUI() {
        strawberryStepper?.rx.value.asObservable().subscribe(onNext: {value in
            print("🍓\(value)")
        }).disposed(by: disposeBag)
        
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
