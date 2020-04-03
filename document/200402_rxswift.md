[https://medium.com/flawless-app-stories/getting-started-with-rxswift-and-rxcocoa-5534cf2902b7](https://medium.com/flawless-app-stories/getting-started-with-rxswift-and-rxcocoa-5534cf2902b7)를 따라해가며 공부했다.

오늘은 이 중 **LoginViewController** 부분을 따라하며 공부했다.

사용했었던 코드 중 `disposed(by: disposeBag)`, `.share(replay: 1)`은 실제 동작을 보고 바로 감을 잡았는데 
`throttle`의 경우는 와닿지가 않아서 어떤 일을 하는지 찾아보고, 다시 동작을 보고 감을 잡았다.

`throttle`은 이벤트가 발생하면 해당 이벤트를 흘려 보내고 이후 **주어진 시간동안의 다른 이벤트들은 무시하고 해당시간이 흐른 후 무시된 이벤트들 중 가장 최신의 이벤트를 흘려보낸다.**

![throttle](https://raw.githubusercontent.com/luire-K/swift_TIL/master/image/throttle.png)

작성한 코드를 보면
`.throttle(throttleInterval, scheduler: MainScheduler.instance)` 인데,
이 경우에는 textField에 연속된 입력에 일일이 다 반응하지 않고 0.1초 안에 하나의 이벤트만 통과시키게 되는 것.

![combineLatest](https://raw.githubusercontent.com/luire-K/swift_TIL/master/image/combineLatest.png)

`.combineLatest`의 경우, 코드만 보고 둘을 합치는 건가 생각하고 있다가 검색 해 보니 두 개의 시퀀스를 하나로 합치는 것이고, 
두 시퀀스는 각각의 최초 이벤트를 발생시켜야 한다는 것도 알 수 있었다.

RxSwift를 공부 해봐야지 하고 찾아볼 때마다 이건 너무 어렵고 복잡하다고 생각했었는데,
막상 이렇게 직접 동작하는 것을 보고 자료를 찾아보니 "아 이렇게 동작한다는 거구나!" 하고 이해가 된다.
이렇게 공부하면서 간단한 프로젝트를 해 보면 좋을거 같다. 
