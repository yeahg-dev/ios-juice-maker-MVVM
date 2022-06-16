# Juice Maker😋

# 프로젝트 소개
`MVVM 아키텍쳐` + `rxSwift`를 프로젝트에 사용해보며 학습하기 위해 만든 토이프로젝트입니다😊

일전에 [MVC로 개발했던 쥬스메이커](https://github.com/yeahg-dev/ios-juice-maker)를 MVVM + rxSwift를 적용하여 새로 구현해보았습니다. 


- 기간 : 2022.5.19 ~ 2022.6.1
- 개인 프로젝트 
- [코드 리뷰](https://github.com/yeahg-dev/ios-juice-maker-MVVM/pull/2) 진행 / 리뷰어 : [줄라이](https://github.com/July911)

## 디렉토리 구조
```bash
├── Presenter
│   ├── JuiceMakerScene
│   │   ├── JuiceMakerViewController
│   │   └── JuiceMakerViewModel
│   └── FruitStockScene
│   	├── FruitStockViewController
│   	└── FruitStockViewModel
├── Usecase
│   └── JuiceMaker
└── Entity
│   ├── FruitJuice
│   └── Fruit
├── Repository
│   └── FruitRepostiory
``` 

## 기능 소개

> 맛있는 과일 주스를 주문하고🧃, 가게의 과일 재고를  관리 할 수 있어요🤗

`주스 주문 버튼`을 눌러 과일 주스를 만들 수 있습니다. 

과일은 필요한 과일만큼 소진됩니다.

<img src="https://user-images.githubusercontent.com/81469717/171651292-b5a09c7e-1906-429a-8c11-c803cb475182.gif" width = "300">


과일이 부족하면 주스를 만들 수 없습니다.

<img src="https://user-images.githubusercontent.com/81469717/171652027-f3584fca-b617-4017-a9fb-f9aed1fcc60f.gif" width = "300">


과일재고를 `스테퍼`로 수정할 수 있습니다.

<img src="https://user-images.githubusercontent.com/81469717/171651805-82c36023-a600-4d02-b4b9-e03005886e72.gif" width = "300">

<br>

# 프로젝트 Output
## 🙌 리뷰를 통해 개선한 점
### 끊어지지 않는 Stream 유지하기
처음에 제가 구현한 ViewModel과 Model에서는 옵저버블을 구독하여 아이템 사용하여 로직을 처리했었습니다. 

이러한 구현에 대해 "View까지 이어지는 스트림에서 중간에 스트림이 분기처리되면 훗날 프로젝트가 커질 때 스트림을 모두 이해하기 어려울 것 같습니다." 라는 [피드백](https://github.com/yeahg-dev/ios-juice-maker-MVVM/pull/2#pullrequestreview-981095025)을 받았습니다. 

- 중간에 스트림이 나뉘게 되면 스트림을 이해하기 어렵다
- 연결된 스트림이 있다면 두 스트림의 싱크를 맞추기 어렵다

라는 문제점이 있을거라 판단했고, 구독을 사용하는 대신 `do` 연산자를 사용하거나, `merge`, `zip`과 같은 Combining 연산자를 사용해 ViewModel과 Model에서의 구독을 제거해주었습니다.

<br>

## ✨ 새롭게 알게된 내용
### Input/Output 구조
뷰에서 보내지는 사용자 이벤트를 정의한 Input과 뷰모델에서 뷰로 바인딩될 데이터 스트림을 정의한 Output 타입을 정의했습니다.

Input/Ouput 구조를 사용하면 아래와 같은 장점이 있다고 생각해 적용해보게 되었습니다.

- 통일된 구조로 구현하기 때문에 가독성이 좋다
- 인풋과 아웃풋을 하나의 타입으로 관리함으로써 관리하기 용이하다

**적용 코드 ⬇️**
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

### Observable 아이템을 효율적으로 공유하는 방법 `share`

하나의 Observable 스트림이 방출하는 아이템을 여러 곳에서 공유해야하는 경우, 하나의 Observable을 여러 곳에서 구독해서 사용하면 비효율적이고, 싱크가 안맞을 수 있습니다. 

`share(replay:)`연산자를 사용하면 구독은 한번 하되, 하나의 시퀀스에서 방출되는 아이템을 공유해서 사용할 수 있습니다.

<br>

### `retry`를 사용한 에러 핸들링
Observable 스트림에서 에러가 방출되면 해당 스트림은 종료됩니다. 계속해서 뷰로 인풋을 받아야하는 스트림에서 에러가 방출되면, 스트림은 종료되고 더 이상 이벤트를 받을 수 없게됩니다. 

이 같은 상황에서 에러가 방출된 시점 후에 `retry`연산자를 호출하면 스트림을 종료시키지 않고 이어나갈 수 있습니다. 

`retry`연산자는 에러가 방출되면 스트림을 dispose하고 **다시 `subscribe`를 호출**합니다. 따라서 에러가 방출되어도 계속해서 사용자 이벤트를 받을 수 있습니다.

**적용 코드 ⬇️**
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
재고가 0이하로 수정되려는 시도가 일어날 때 `fruitReductionFailure`에러가 방출됩니다. `retry(when:)` 연산자를 활용, 스테퍼 인풋이 들어올 때(`steppValue`시퀀스가 생성) 재구독하여 스트림이 종료되지 않도록 해결했습니다.

<br>

### 메서드 호출로 Observable sequence 생성하기
뷰 라이프 사이클 이벤트가 발생할 때 새로운 옵저버블 시퀀스를 생성해야하는 경우, 특정 메서드를 trigger로 새로운 시퀀스를 생성해야하는 경우  rxExtension의 `func methodInvoked(_ selector: Selector) -> Observable<[Any]>`을 활용했습니다.

```swift
let input = JuiceMakerViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map{_ in},
            presentedViewDismissed: self.rx.methodInvoked(#selector(JuiceMakerViewController.presentedViewControllerDidDismissed)).map{_ in},
            ...
            )
```

 <br>
       
## 🤔 MVVM + rxSwift 회고
장점😙👍

- 기존의 MVC 아키텍쳐에선 뷰컨트롤러에서 있던 비지니스로직을 뷰모델이 관리함으로서 뷰의 재사용이 좋아진다. (수동적인 뷰)
- presentation layer와 businessLogic layer를 완전히 분리할 수 있다.
- 따라서 테스트가 용이할 것 같다. 
- `모델` -> `뷰` 로의 데이터 전달에 대한 구독을 한번 해두면 UI 업데이트 호출을 별도로 해주지 않아도 된다.   
- 오퍼레이터를 정확히 이해하고 적재적소에 잘 활용하는 것이 중요하다

단점🤨

- rxSwift 라이브러리 내부 구현을 완벽히 이해하지 않는 이상, 메모리나 퍼포먼스에 영향을 파악하기 어렵다.
- 오퍼레이터를 잘 모르고 사용할시 예상치 못한 흐름을 만들어낼 수 있으니 매우!! 공부가 필요하다.
- 클로저를 많이 사용하기 때문에 강한 순환 참조로 인한 메모리 누수에 유의해야한다.

결론✨

- 비동기 통신이 이뤄지는 구조에서 사용하면 동기 코드 처럼 가독성을 좋게 깔끔하게 코드를 작성할 수 있을 것 같다👍
- 오퍼레이터를 정확하게 이해하고 사용하자!!!!⭐️⭐️⭐️
- 라이브러리 내부 구현을 틈틈이 이해해보려 노력하자.

