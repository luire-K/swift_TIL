[RxSwift+MVVM 4시간에 끝내기](https://www.youtube.com/watch?v=iHKBNYMWd5I) 중 4교시까지 보며 공부했다.

오늘도 `Behaviorsubject` 외 몇 가지의 Marble Diagram을 더 보고 흐름을 이해하는데 많은 도움을 받았다.

```swift
.subscribe(onNext: { [weak self]
   self?.totalPrice.text = $0
})
```
를 간결하게 (sugar api)하면
```swift
.bind(to: self.totalPrice.rx.text)
```
이렇게 표현된다는 것도 알게 되었는데, 안 그래도 간결한데 더 간결하게 할 수 있는 방식이 계속 나오는게 놀라웠다.

저번 튜토리얼에서도 UITableViewDataSource extension없이 처리하는데에 상당히 놀랐는데 
이번에는 Rxcocoa를 통해 tableView와 label도 바인딩하여 처리하는 걸 배울 수 있었다.

특히나 viewModel을 사용하는 MVVM 디자인패턴도 경험해 볼 수 있었다.
그동안의 회사 프로젝트들에서는 MVC만 사용했었는데 요즘 많은 곳에서 MVVM으로 바꿔나가는지 알게 되는 계기가 되었다.
얼른 익숙해져서 RxSwift와 MVVM을 사용할 수 있었으면...
앞으로도 많이 찾아보고 공부해야 하겠지만 이번주를 계기로 RxSwift나 MVVM에 대한 부담스러움은 조금 내려놓게 되었다. 

이런 좋은 강의를 이렇게 쉽게 접할 수 있게 올려주신 곰튀김님께 감사드린다.