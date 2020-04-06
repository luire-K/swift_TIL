Background에서 gps를 트래킹해야 하는데 처음 해 보는 것이라 정리해 둔다.

<img width="830" alt="Screen Shot 2020-04-06 at 9 12 03 PM" src="https://user-images.githubusercontent.com/59459198/78564932-1e5ba880-7858-11ea-9748-2315fd47e214.png">

Capablities에서 Background Modes를 추가하고, Location Updates에 체크한다.
info.plist에 `LocationWhenInUseUsageDescription`를 추가한다.
CoreLocation 을 임포트하고 
ViewController에서는 `
CLLocationManagerDelegate` 프로토콜을 채택.

```swift
let locationManager = CLLocationManager() 	// 인스턴스생성
locationManager.delegate = self 	// 델리게이트 연결
locationManager.requestAlwaysAuthorization() 	// 위치권한요청
locationManager.allowsBackgroundLocationUpdates = true 	// background location tracking 허용
locationManager.startUpdatingLocation() 	// 위치 업데이트 시작
```
일단은 이렇게 하면 기본적인 준비는 완료.

*CLLocationManager는 위치 관련 이벤트가 앱으로 전송되는 것을 시작하고 중지하는 데 사용된다. 

참고한 문서는
https://developer.apple.com/documentation/corelocation/cllocationmanager
https://developer.apple.com/documentation/corelocation/adding_location_services_to_your_app