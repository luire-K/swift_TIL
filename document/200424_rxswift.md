[RxSwift 4시간에 끝내기 시즌1](https://www.youtube.com/playlist?list=PL03rJBlpwTaBBtiJ0BtgASCsS4ye-4gC7)을 들었다.

오늘은 따로 스터디가 또 있어서 많이 볼 수는 없었는데, 
Subject와 Relay, Observable과 Driver 는 무슨 차이가 있는지,
map과 flatMap는 어떻게 다른지에 대해 좀 더 자세히 설명을 들을 수 있었다.

subject는 completed, error이벤트가 발생하면 subscribe가 종료되는 반면
relay는 스트림 종료가 되지 않는다고. completed, error가 나도 Dispose되기 전까지 작동.

subject는 observable이라 subscribe를 할 수 있다. 
하지만 Relay는 asObservable을 사용해야 한다.

Driver는 Observable이 에러를 무시하고 싶을 때 사용한다고.
subscribe 대신 asDriver()로 바뀌면 drive(onNext:)를 해야 한다.
Driver는 에러(onError)가 없다고.

그래서 UI와 연결할 때는 relay, drive를 사용한다. 
둘 다 사용할 때는 RxCocoa를 import 해서 사용한다.

map과 flatmap을 마블 다이어그램을 보면서 설명하자면,
map은 벨류값이 들어와서 어떠한 벨류값이 리턴되고, flatmap은 벨류가 들어와서 옵저버블로 리턴되는 것이 큰 차이.

일단 오늘은 여기까지 들었고 내일은 못 들은 부분까지 좀 더 듣고, 
검색으로 자료 더 찾아서 보면서 공부해야겠다.