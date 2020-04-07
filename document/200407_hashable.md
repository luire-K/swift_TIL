swift에서 Dictionary의 key값으로 사용되기 위해서는 해당 타입이 반드시  `hashable`을 준수해야 한다고 하는데, `hashable`을 제대로 이해 못 한 것 같아서 찾아보았다. 

애플 공식문서에 보면 `정수 hash값을 제공하는 타입 (A type that provieds an integer hash value)`라고 한다.

-   `Hashable`을 채택한 자료형은 모두 `Set`와 `Dictionary`의 `Key`로 사용할 수 있다.
-   Swift의 표준 라이브러리의 많은 자료형은(`String`, `Int`, `Float`, `Bool`…) 기본적으로 Hash가 가능하다.
-   구조체의 경우 모든 저장 프로퍼티는 반드시 `Hashable`을 채택해야 한다.

결국 이 말은 Hash는 "그 자체로 유일한 값"

```swift
struct Person: Hashable {
    var name: String 
    var age: Int
}

let duggea = Person(name: "홍두깨", age: 20)
let gildong = Person(name: "홍길동", age: 30)

if duggea == gildong {
    print("나이가 같습니다")
}  else {
    print("나이가 다릅니다")
}
// 결과: "나이가 다릅니다" 
```

위 코드의 경우 Person이라는 struct가 name 프로퍼티와 age 프로퍼티를 가지고 있고 각각 `String`, `Int` 형으로 `Hashable`을 채택했다는 것.

이미 잘 쓰고 있었고, 너무 당연하게 쓰고 있어서 "왜" 쓰는지 생각 않고 있었는데 얻는게 많았다.
불현듯 생각이 나서 진짜 완전 기본적인 것만 찾아보았는데, 
시간이 되면 이 부분은 좀 더 구체적으로 찾아서 공부해보아야 할거 같다.