[100Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui)를 시작하였다.

Day 15까지는 swift 기본문법을 설명하고 있어서, 
나는 SwiftUI를 본격적으로 하는 Day 16부터 시작했다.

어제했던 튜토리얼과 같은 내용이 있기도 하고 추가로 알게 된 내용도 있다.

SwiftUI에서 최상위 View는 최대 10개의 ChildView를 가질 수 있고, 
10개를 초과하게 되면 다른 태그들을 이용해 감싸주어야 한다. 

튜토리얼에서는 Form 컨테이너에 Textview를 11개 추가하니 바로 에러가 나는 모습을 볼 수 있었고,
Group과 Section으로 감싸서 어떻게 보여지는지 확인 할 수 있었다.

```swift
struct ContentView: View {
    @State private var name = ""

    var body: some View {
        Form {
            TextField("이름을 입력하세요", text: $name)
            Text("당신의 이름은 \(name)")
        }
    }
}
```
위의 코드의 경우 Textfield에 이름을 입력하면 아래줄에 입력한 이름이 보여지게 되는데
이를 가능하게 하는게 name이라는 속성 앞에 `$`를 추가한 것이다.
속성 이름 앞에 `$`가 표시되면 양방향 바인딩을 생성한다는 것.

SwiftUI는 배열과 범위를 반복하여 필요한만큼 많은 뷰를 보여주기 위해 전용 뷰 유형인 ForEach를 제공한다. 

되도록이면 하루에 1Day혹은 2Day씩 꼬박꼬박 해서 100Day까지 다 해보고 개인프로젝트를 해 보려고 한다.