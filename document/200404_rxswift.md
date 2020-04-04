[RxSwift+MVVM 4시간에 끝내기](https://www.youtube.com/watch?v=iHKBNYMWd5I) 중 1교시 를 보며 공부했다.

이틀에 걸쳐 했던 튜토리얼을 하고 나서 이 강의를 보니 그래서 이걸 썼구나 하며 깨닫게 된 것들이 많았다.

 ```swift
 Observable.just("Hello World")
 ```
는
```swift 
Observable.create { emitter in  
   emitter.onNext("Hello World")  
   emitter.onCompleted()  
   return Disposables.create()  
 } 
```

을 표현한 것과 같다고 설명해 주셨을 때, 
그동안 봐 왔던 코드들이 다 축약된 sugar api였구나 하고 이해가 되었다.
그 긴 코드들을 저렇게 간결하게 했으니 아무것도 모르는 상황에서 봤을 때는 어려워하고 이해가 안될만도 했다...

```swift
 .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
```
을 설명해주시면서 Marble Diagram을 제대로 보는 법도 배울 수 있었는데, 
어제 봤던 Marble Diagram을 보니 맞게 이해 한 것 같아서 다행이었다.
다음부터는 찾아보기고 이해하기가 한결 수월해질 것 같다.

총 4교시 수업중에 1교시만 들었는데도 이렇게 깨닫고 얻어 가는게 많으니 나머지 교시는 얼마나 더 배우게 될지 기대가 된다.