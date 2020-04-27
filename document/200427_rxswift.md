오늘은 pilgwon님께서 번역해주신 [예제로 시작하는 RxSwift ](https://pilgwon.github.io/blog/2017/09/26/RxSwift-By-Examples-1-The-Basics.html) 튜토리얼을 따라해 보았다.

구글에서 RxSwift를 검색했다면 안 본 사람이 없지 않을까.

`City Searcher` 라는 앱으로 searchBar에 도시 이름을 입력하면 목록을 보여 주는 앱을 만든다.

먼저 UI를 만들었다. 스토리보드에 searchBar와 tableView를 올려서 만들고 UI쪽 코드는 이렇게 작성했다.
```swift
@IBOutlet weak var searchBar: UISearchBar!
@IBOutlet weak var tableView: UITableView!
 
 var shownCities = [String]()
 let allCities = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

override func viewDidLoad() {
	
	super.viewDidLoad()
	tableView.delegate = self
	tableView.dataSource = self
  }
```
그리고 RxSwift코드를 추가 했다. 옆에 달린 주석은 무시하고 보려고 노력했고, 
이 코드는 이런 의미로 썼구나 하고 확인하는 정도로 했는데 다 맞아서 아 활용은 아직 안해봤지만 코드를 읽을 수는 있구나 하고 안심하게 되었다.

```swift 
searchBar
   .rx.text
   .orEmpty  // 옵셔널이 아니게 만듦
   .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // API의 과도한 호출을 방지하기 위해 0.5초 기다린다. 안 줄 경우, 모든 입력을 받음. 
   .distinctUntilChanged()  // 새로운 값이 이전과 같은지 체크
   .filter({ !$0.isEmpty })
   .subscribe(onNext: { [unowned self] query in
    self.shownCities = self.allCities.filter({ $0.hasPrefix(query) })
    self.tableView.reloadData()
 })
   .disposed(by: disposeBag)
```
튜토리얼이 RxSwift3 버전이라 두어군데는 새로운 코드로 바뀌었다.
`.debounce(0.5, scheduler: MainScheduler.instance)` 는 
`.debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)` 으로 수정하자 에러가 사라졌고

`.addDisposableTo(disposeBag)` 라는 코드가 있는 위치도 그렇고 코드에 disposeBag이 있어서 
`.disposed(by: disposeBag)`로 대신 쓰는 구나 하고 알게 되었다.

간단한 튜토리얼을 하면서 새로운 함수를 알게 되었다.
`debounce`는 마블다이어그램을 찾아서 보니, 
![68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f34383937312f33623430343731622d623663332d363635382d623965312d6335656330313164333335302e706e67](https://user-images.githubusercontent.com/59459198/80384982-8134e280-88e0-11ea-86ae-03085c1806d0.png)

타이머를 지정해두고 타이머가 끝난 시점에 가장 최근의 값을 방출해준다는 거 같았다.
다이어그램상에는 1부터 3눙에서 타이머가 끝났을때 가장 가까운 3을, 뒤이어 온 subscriber에서도 가장 최근 시점인 6이 방출됨을 알 수 있다.

`distinctUntilChanged()`도 마블 다이어그램 찾아서 보니
![1*9N2PP9UYLxHTKicEUAK-vQ](https://user-images.githubusercontent.com/59459198/80385207-bfca9d00-88e0-11ea-99f4-36652f0e4925.png)
이전 이벤트와 비교했을 때 다른 이벤트만을 흘려보낸다는 걸 알 수 있었다.
빨간 1와 빨간 2는 서로 벨류값이 다르기때문에 흘려보냈고, 빨간 2와 파란 2는 벨류값이 같기 때문에 파란 2를 흘려보내지 않았다.

아무것도 모르던 RxSwift 초보가 이젠 코드를 어느정도는 파악이 가능할 정도가 되다니...
하지만 갈 길이 멀다 부지런히 가자... 