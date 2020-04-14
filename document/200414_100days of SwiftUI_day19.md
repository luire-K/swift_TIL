[100Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui) Day 19는
그동안 배운 걸 바탕으로 단위 변환을 처리하는 앱을 구현해보는 챌린지를 하였다.

사용자는 입력 단위와 출력 단위를 선택한 다음 값을 입력하고 변환 결과를 확인 할 수
있게 하는 것으로 나는 `길이 변환`을 선택해서,
사용자가 meters, kilometers, feets, yards, miles로 입력, 반환을 할 수 있게 하였다.

매번 계산을 하지않을 수 있는 방법을 고민하라는 내용이 있어서 enum으로 처리를 했는데
enum에 대해 공부하다가 CaseIterable라는 프로토콜을 처음으로 사용해보게 되었다.

그동안 enum을 그렇게 자주쓰는 편도 아니라 CaseIterable을 처음 접하게 되었는데 
enum이 CaseIterable를 준수하기만 하면 자동으로 열거형의 모든 case에 대한 collection을 만들어준다고.

자동으로 **사용자가 정의한 순서대로** 모든 case의 배열인 “**allCases**”프로퍼티를 생성한다고 해서 사용해 보았는데 
```swift 
 enum MeasureUnit: CaseIterable {
        case meters, kilometers, feets, yards, miles
 }
 MeasuerUnit.allCases
 MeasuerUnit.allCases.count // return 5
 
 for measure in MeasuerUnit.allCases {
	 print (measure)
 } 
 // meters
 // kilometers
 // feets
 // yards
 // miles
```
로 나오는 것을 확인 할 수 있었다.

기회가 생기면 프로젝트에 활용해봐야겠다. 