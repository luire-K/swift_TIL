[100Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui) Day 23에서는 새로운 것들을 배웠다.

SwiftUI는 전반적으로 구조체를 사용하는 것을 선호하는데 몇 가지 이유가 있다고.
첫 번째가 성능, 두 번째가 상속으로 인한 불필요한 인터페이스라고 하였다.
특히 UIView는 상속하기만해도 200여개의 프로퍼티가 오기 때문이라고.

Modifier가 호출되면 SwiftUI는 Generic을 이용하여 modifier를 적용한 ModiFiedContent 라는 View를 리턴한다고 한다.
또한 Modifier가 여러개일 경우에는 Stack처럼 쌓이게 되어, 이 때문에 순서에 따라 동작이 달라지기도 한다고 한다. 
그리고 같은 modifier를 여러번 호출 하여도 효과가 반복 된다고 한다.

modifier는 View의 상태를 변경하는 것이 아니라 ModifiedContent라는 새로운 View를  리턴해서
```swift
var body: some View {
    if self.useRedText {
        return Text("Hello World")
    } else {
        return Text("Hello World")
            .background(Color.red)
    }
}
```
이러한 코드는 사용 할 수 없는데, 왜냐하면 some View는 한가지 타입이어야 하는데, .background()를 호출하게 되면 리턴되는 타입은 ModifiedContent이기 때문이라고.  

```swift
struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            self.useRedText.toggle()            
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}
```
이와 같이 사용해야 한다고 한다.

오늘은 첼린지가 아니라 새로운 것들을 배웠는데 배운 분량이 갑자기 확 늘어서 
내일거를 공부하기 전에 한 번 더 살펴보고 해야 할 것 같다.
