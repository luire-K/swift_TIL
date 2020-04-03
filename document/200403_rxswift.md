[https://medium.com/flawless-app-stories/getting-started-with-rxswift-and-rxcocoa-5534cf2902b7](https://medium.com/flawless-app-stories/getting-started-with-rxswift-and-rxcocoa-5534cf2902b7)를 따라해가며 공부했다.

오늘은 이 중 **MenuViewController, ShoppingCart, ShoppingCartViewController** 부분을 따라하며 공부했다.

오늘은 **BehaviourSubject**라는 **Observable**이 아닌 새로운 유형이 등장했다.

![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/behaviorsubject.png)

그림을 보고도 잘 와닿지가 않아서 좀 더 찾아보니, behaviorSubject는 초기값을 가지고 있는 subject이고, 
구독이 발생하면 즉시 현재 저장된 값을 이벤트로 전달한다고 한다. 
마지막 이벤트 값을 저장하고 싶을때 사용한다고. 

그래서 에러가 발생하게 되면 에러를 전달하게 된다고 한다.
 (마지막 값이 에러니까 에러를 전달하게 되는 것!)

튜토리얼을 따라하다보니 UITableViewDelegate/ UITableViewDataSource extension없이 처리 할 수 있는 것이 상당히 인상적이었다.

이제 한 걸음 내딛었다.
