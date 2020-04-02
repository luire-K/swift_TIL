### cocoaPods (navermap) build error

naverMap을 추가하고 빌드를 하는데

``` 
.../Pods/NMapsMap/framework/NMapsMap.framework/NMapsMap, 
building for iOS Simulator-x86_64 but attempting to link with file built for unknown-unsupported file format 
```

라는 오류가 생겼다.

에러문구를 검색 후 발견한 [블로그](http://susenmi99.kr/6178)를 보고 그대로 진행하였는데도 여전히 해결이 되지 않았다.
블로그에서 "그래도 에러가 생기면 확인해야 한다." 하는 것도 다 해봤는데.

이렇게 해서 안되는거면 혹시나 cocoaPods 자체가 꼬여버린거 아닐까 하고
cocoaPods를 지우고 다시 해보았지만 변함이 없었다.

검색해 보니 지우고 재설치 말고도 추가적으로 해야 할 것이 있었다.

1. Pods 폴더 삭제 (폴더 포함 그 자체를 다 삭제) 
2. Podfile.lock 파일 삭제
3. [프로젝트이름].xcworkspace 파일 삭제
4. [프로젝트이름].xcodeproj 우클릭 후
	 * 패키지 내용보기 선택
	 * project.pbxproj를 제외한 모든 파일 삭제.
 5. Podfile이 있는 폴더에서 다시 `pod install` 실행 후 
 6. 새로 생긴 [프로젝트이름].xcworkspace 실행하여 확인 

 을 진행하니 정상적으로 빌드가 되는 것을 확인 할 수 있었다.
 이 [repository](https://ClintJang/cocoapods-tip)가 많은 도움이 되었다.

이러한 cocoaPods 이슈는 언제든지 발생 할 수 있어 쉽게 찾아 볼 수 있게 기록해둔다.

