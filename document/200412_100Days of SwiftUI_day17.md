[100Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui) Day 17에서는 textfield에 값을 받아 팁을 계산하고
인원수대로 나눌 수 있게 하는 기능을 가진 간단한 앱을 만들었다.

textfield에 placeholder를 삽입하고, 키보드 타입을 설정하는게 
기존보다 굉장히 쉽고 더 빨라져서 (코드가 엄청 짧아짐) 타이핑하면서도 신기했다.

그리고 Day16에서 배운 Picker와 ForEach를 다시 한 번 사용해서 인원수를 입력 할 수 있게 하였다.

팁 비율을 선택할 수 있게 세그먼트 컨트롤을 추가하였는데, SwiftUI에서는 "세그먼트"라는 이름을 가진 뷰가 따로 있는게 아니라 picker 컨테이너를 만들고 스타일에서 따로 선택하는 방식이었다.

```swift
Section(header: Text("팁을 얼마나 주고 싶은가요?")){
	Picker {
		//보여줄 내용
	}
	.pickerStyle(SegmentedPickerStyle())
}
```

 그리고 섹션에 헤더를 넣는게 엄청 쉬워졌다. 
 `header`라고 표시하고 바로 사용하면 되어서 기존 방식으로 하는 것보다 몇 줄이나 줄어든 건지...

100Days of SwiftUI에서 공부한 것은 TIL에 오늘 올린 것처럼 올리려고 한다.
상세하게 다루지 않고 "이런걸 배웠다." 하는 정도로만 올리고 튜토리얼을 따라한 파일을 올리는 식으로 하려고 한다.
쉽게 배울 수 있게 올려주신 컨텐츠를 여기다 상세하게 적는건 좀 아닌거 같아서.. 