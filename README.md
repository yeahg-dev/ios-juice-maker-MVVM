# Juice Makerπ

# νλ‘μ νΈ μκ°
`MVVM μν€νμ³` + `rxSwift`λ₯Ό νλ‘μ νΈμ μ¬μ©ν΄λ³΄λ©° νμ΅νκΈ° μν΄ λ§λ  ν μ΄νλ‘μ νΈμλλ€π

μΌμ μ [MVCλ‘ κ°λ°νλ μ₯¬μ€λ©μ΄μ»€](https://github.com/yeahg-dev/ios-juice-maker)λ₯Ό MVVM + rxSwiftλ₯Ό μ μ©νμ¬ μλ‘ κ΅¬νν΄λ³΄μμ΅λλ€. 


- κΈ°κ° : 2022.5.19 ~ 2022.6.1
- κ°μΈ νλ‘μ νΈ 
- [μ½λ λ¦¬λ·°](https://github.com/yeahg-dev/ios-juice-maker-MVVM/pull/2) μ§ν / λ¦¬λ·°μ΄ : [μ€λΌμ΄](https://github.com/July911)

## λλ ν λ¦¬ κ΅¬μ‘°
```bash
βββ Presenter
β   βββ JuiceMakerScene
β   β   βββ JuiceMakerViewController
β   β   βββ JuiceMakerViewModel
β   βββ FruitStockScene
β   	βββ FruitStockViewController
β   	βββ FruitStockViewModel
βββ Usecase
β   βββ JuiceMaker
βββ Entity
β   βββ FruitJuice
β   βββ Fruit
βββ Repository
β   βββ FruitRepostiory
``` 

## κΈ°λ₯ μκ°

> λ§μλ κ³ΌμΌ μ£Όμ€λ₯Ό μ£Όλ¬Ένκ³ π§, κ°κ²μ κ³ΌμΌ μ¬κ³ λ₯Ό  κ΄λ¦¬ ν  μ μμ΄μπ€

`μ£Όμ€ μ£Όλ¬Έ λ²νΌ`μ λλ¬ κ³ΌμΌ μ£Όμ€λ₯Ό λ§λ€ μ μμ΅λλ€. 

κ³ΌμΌμ νμν κ³ΌμΌλ§νΌ μμ§λ©λλ€.

<img src="https://user-images.githubusercontent.com/81469717/171651292-b5a09c7e-1906-429a-8c11-c803cb475182.gif" width = "300">


κ³ΌμΌμ΄ λΆμ‘±νλ©΄ μ£Όμ€λ₯Ό λ§λ€ μ μμ΅λλ€.

<img src="https://user-images.githubusercontent.com/81469717/171652027-f3584fca-b617-4017-a9fb-f9aed1fcc60f.gif" width = "300">


κ³ΌμΌμ¬κ³ λ₯Ό `μ€ννΌ`λ‘ μμ ν  μ μμ΅λλ€.

<img src="https://user-images.githubusercontent.com/81469717/171651805-82c36023-a600-4d02-b4b9-e03005886e72.gif" width = "300">

<br>

# νλ‘μ νΈ Output
## π λ¦¬λ·°λ₯Ό ν΅ν΄ κ°μ ν μ 
### λμ΄μ§μ§ μλ Stream μ μ§νκΈ°
μ²μμ μ κ° κ΅¬νν ViewModelκ³Ό Modelμμλ μ΅μ λ²λΈμ κ΅¬λνμ¬ μμ΄ν μ¬μ©νμ¬ λ‘μ§μ μ²λ¦¬νμμ΅λλ€. 

μ΄λ¬ν κ΅¬νμ λν΄ "ViewκΉμ§ μ΄μ΄μ§λ μ€νΈλ¦Όμμ μ€κ°μ μ€νΈλ¦Όμ΄ λΆκΈ°μ²λ¦¬λλ©΄ νλ  νλ‘μ νΈκ° μ»€μ§ λ μ€νΈλ¦Όμ λͺ¨λ μ΄ν΄νκΈ° μ΄λ €μΈ κ² κ°μ΅λλ€." λΌλ [νΌλλ°±](https://github.com/yeahg-dev/ios-juice-maker-MVVM/pull/2#pullrequestreview-981095025)μ λ°μμ΅λλ€. 

- μ€κ°μ μ€νΈλ¦Όμ΄ λλκ² λλ©΄ μ€νΈλ¦Όμ μ΄ν΄νκΈ° μ΄λ ΅λ€
- μ°κ²°λ μ€νΈλ¦Όμ΄ μλ€λ©΄ λ μ€νΈλ¦Όμ μ±ν¬λ₯Ό λ§μΆκΈ° μ΄λ ΅λ€

λΌλ λ¬Έμ μ μ΄ μμκ±°λΌ νλ¨νκ³ , κ΅¬λμ μ¬μ©νλ λμ  `do` μ°μ°μλ₯Ό μ¬μ©νκ±°λ, `merge`, `zip`κ³Ό κ°μ Combining μ°μ°μλ₯Ό μ¬μ©ν΄ ViewModelκ³Ό Modelμμμ κ΅¬λμ μ κ±°ν΄μ£Όμμ΅λλ€.

<br>

## β¨ μλ‘­κ² μκ²λ λ΄μ©
### Input/Output κ΅¬μ‘°
λ·°μμ λ³΄λ΄μ§λ μ¬μ©μ μ΄λ²€νΈλ₯Ό μ μν Inputκ³Ό λ·°λͺ¨λΈμμ λ·°λ‘ λ°μΈλ©λ  λ°μ΄ν° μ€νΈλ¦Όμ μ μν Output νμμ μ μνμ΅λλ€.

Input/Ouput κ΅¬μ‘°λ₯Ό μ¬μ©νλ©΄ μλμ κ°μ μ₯μ μ΄ μλ€κ³  μκ°ν΄ μ μ©ν΄λ³΄κ² λμμ΅λλ€.

- ν΅μΌλ κ΅¬μ‘°λ‘ κ΅¬ννκΈ° λλ¬Έμ κ°λμ±μ΄ μ’λ€
- μΈνκ³Ό μμνμ νλμ νμμΌλ‘ κ΄λ¦¬ν¨μΌλ‘μ¨ κ΄λ¦¬νκΈ° μ©μ΄νλ€

**μ μ© μ½λ β¬οΈ**
```swift
//  JuiceMakerViewModel.swift

 struct Input {
        let viewWillAppear: Observable<Void>
        let presentedViewDismissed: Observable<Void>
        let strawberryButtonTapped: Observable<Void>?
        let peachButtonTapped: Observable<Void>?
        let strawberryPeachButtonTapped: Observable<Void>?
        let pineappleButtonTapped: Observable<Void>?
        let watermelonButtonTapped: Observable<Void>?
        let watermelonPineappleButtonTapped: Observable<Void>?
        let bananaButtonTapped: Observable<Void>?
    }
    
    struct Output {
        let strawberryStock: Observable<String>
        let peachStock: Observable<String>
        let pineappleStock: Observable<String>
        let watermelonStock: Observable<String>
        let bananaStock: Observable<String>
        let alertMessage: PublishSubject<JuiceMakerUserNotification>
    }
```
<br>

### Observable μμ΄νμ ν¨μ¨μ μΌλ‘ κ³΅μ νλ λ°©λ² `share`

νλμ Observable μ€νΈλ¦Όμ΄ λ°©μΆνλ μμ΄νμ μ¬λ¬ κ³³μμ κ³΅μ ν΄μΌνλ κ²½μ°, νλμ Observableμ μ¬λ¬ κ³³μμ κ΅¬λν΄μ μ¬μ©νλ©΄ λΉν¨μ¨μ μ΄κ³ , μ±ν¬κ° μλ§μ μ μμ΅λλ€. 

`share(replay:)`μ°μ°μλ₯Ό μ¬μ©νλ©΄ κ΅¬λμ νλ² νλ, νλμ μνμ€μμ λ°©μΆλλ μμ΄νμ κ³΅μ ν΄μ μ¬μ©ν  μ μμ΅λλ€.

<br>

### `retry`λ₯Ό μ¬μ©ν μλ¬ νΈλ€λ§
Observable μ€νΈλ¦Όμμ μλ¬κ° λ°©μΆλλ©΄ ν΄λΉ μ€νΈλ¦Όμ μ’λ£λ©λλ€. κ³μν΄μ λ·°λ‘ μΈνμ λ°μμΌνλ μ€νΈλ¦Όμμ μλ¬κ° λ°©μΆλλ©΄, μ€νΈλ¦Όμ μ’λ£λκ³  λ μ΄μ μ΄λ²€νΈλ₯Ό λ°μ μ μκ²λ©λλ€. 

μ΄ κ°μ μν©μμ μλ¬κ° λ°©μΆλ μμ  νμ `retry`μ°μ°μλ₯Ό νΈμΆνλ©΄ μ€νΈλ¦Όμ μ’λ£μν€μ§ μκ³  μ΄μ΄λκ° μ μμ΅λλ€. 

`retry`μ°μ°μλ μλ¬κ° λ°©μΆλλ©΄ μ€νΈλ¦Όμ disposeνκ³  **λ€μ `subscribe`λ₯Ό νΈμΆ**ν©λλ€. λ°λΌμ μλ¬κ° λ°©μΆλμ΄λ κ³μν΄μ μ¬μ©μ μ΄λ²€νΈλ₯Ό λ°μ μ μμ΅λλ€.

**μ μ© μ½λ β¬οΈ**
```swift
// FruiStockViewModel.swift 

 private func transform(of fruit: Fruit, input: Input) -> Observable<String> {
        var initialStock: Observable<Int>
        var stepperValue: Observable<Int>
        var stockUpdateResult: Observable<Void>
        var updatedStock: Observable<String>
        
        ...
        
        stockUpdateResult = Observable<Int>
            .combineLatest(initialStock, stepperValue){ $0 + $1}
            .flatMap {
            self.juiceMaker.modifyFruitStock(of: fruit, with: $0)
            }
            .share(replay: 1)
        
        updatedStock = stockUpdateResult
            .withUnretained(self)
            .do(onError: { _ in
                self.userNotification.onNext(UserNotification())
            })
            .flatMap{ _ -> Observable<Int> in
                self.juiceMaker.fruitStockObservable(of: fruit)
            }
            .map{String($0)}
            .retry(when: { _ in
                stepperValue
            })

        return updatedStock
    }
}
```
μ¬κ³ κ° 0μ΄νλ‘ μμ λλ €λ μλκ° μΌμ΄λ  λ `fruitReductionFailure`μλ¬κ° λ°©μΆλ©λλ€. `retry(when:)` μ°μ°μλ₯Ό νμ©, μ€ννΌ μΈνμ΄ λ€μ΄μ¬ λ(`steppValue`μνμ€κ° μμ±) μ¬κ΅¬λνμ¬ μ€νΈλ¦Όμ΄ μ’λ£λμ§ μλλ‘ ν΄κ²°νμ΅λλ€.

<br>

### λ©μλ νΈμΆλ‘ Observable sequence μμ±νκΈ°
λ·° λΌμ΄ν μ¬μ΄ν΄ μ΄λ²€νΈκ° λ°μν  λ μλ‘μ΄ μ΅μ λ²λΈ μνμ€λ₯Ό μμ±ν΄μΌνλ κ²½μ°, νΉμ  λ©μλλ₯Ό triggerλ‘ μλ‘μ΄ μνμ€λ₯Ό μμ±ν΄μΌνλ κ²½μ°  rxExtensionμ `func methodInvoked(_ selector: Selector) -> Observable<[Any]>`μ νμ©νμ΅λλ€.

```swift
let input = JuiceMakerViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map{_ in},
            presentedViewDismissed: self.rx.methodInvoked(#selector(JuiceMakerViewController.presentedViewControllerDidDismissed)).map{_ in},
            ...
            )
```

 <br>
       
## π€ MVVM + rxSwift νκ³ 
μ₯μ ππ

- κΈ°μ‘΄μ MVC μν€νμ³μμ  λ·°μ»¨νΈλ‘€λ¬μμ μλ λΉμ§λμ€λ‘μ§μ λ·°λͺ¨λΈμ΄ κ΄λ¦¬ν¨μΌλ‘μ λ·°μ μ¬μ¬μ©μ΄ μ’μμ§λ€. (μλμ μΈ λ·°)
- presentation layerμ businessLogic layerλ₯Ό μμ ν λΆλ¦¬ν  μ μλ€.
- λ°λΌμ νμ€νΈκ° μ©μ΄ν  κ² κ°λ€. 
- `λͺ¨λΈ` -> `λ·°` λ‘μ λ°μ΄ν° μ λ¬μ λν κ΅¬λμ νλ² ν΄λλ©΄ UI μλ°μ΄νΈ νΈμΆμ λ³λλ‘ ν΄μ£Όμ§ μμλ λλ€.   
- μ€νΌλ μ΄ν°λ₯Ό μ νν μ΄ν΄νκ³  μ μ¬μ μμ μ νμ©νλ κ²μ΄ μ€μνλ€

λ¨μ π€¨

- rxSwift λΌμ΄λΈλ¬λ¦¬ λ΄λΆ κ΅¬νμ μλ²½ν μ΄ν΄νμ§ μλ μ΄μ, λ©λͺ¨λ¦¬λ νΌν¬λ¨Όμ€μ μν₯μ νμνκΈ° μ΄λ ΅λ€.
- μ€νΌλ μ΄ν°λ₯Ό μ λͺ¨λ₯΄κ³  μ¬μ©ν μ μμμΉ λͺ»ν νλ¦μ λ§λ€μ΄λΌ μ μμΌλ λ§€μ°!! κ³΅λΆκ° νμνλ€.
- ν΄λ‘μ λ₯Ό λ§μ΄ μ¬μ©νκΈ° λλ¬Έμ κ°ν μν μ°Έμ‘°λ‘ μΈν λ©λͺ¨λ¦¬ λμμ μ μν΄μΌνλ€.

κ²°λ‘ β¨

- λΉλκΈ° ν΅μ μ΄ μ΄λ€μ§λ κ΅¬μ‘°μμ μ¬μ©νλ©΄ λκΈ° μ½λ μ²λΌ κ°λμ±μ μ’κ² κΉλνκ² μ½λλ₯Ό μμ±ν  μ μμ κ² κ°λ€π
- μ€νΌλ μ΄ν°λ₯Ό μ ννκ² μ΄ν΄νκ³  μ¬μ©νμ!!!!β­οΈβ­οΈβ­οΈ
- λΌμ΄λΈλ¬λ¦¬ λ΄λΆ κ΅¬νμ ννμ΄ μ΄ν΄ν΄λ³΄λ € λΈλ ₯νμ.

