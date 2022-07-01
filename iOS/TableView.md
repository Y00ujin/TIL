
# **UITableView**

- #### ```EZYLIST``` 구현해보기 with Code 👩🏻‍💻

##### 1. SnapKit을 ```install```, ```import```해주자
###### SnapKit을 먼저 Podfile에 넣고 install한 후에 import해주자.
```Swift
import SnapKit
```

##### 2. TableView 생성!
```Swift
    let EZYLISTTableView: UITableView = UITableView()
```

##### 4. TableViewCell에 들어갈 요소들 선언!
```Swift
    let groupNameArray: [String] = ["NEULSOM", "공부", "산책", "심부름", "NEULSOM", "공부", "산책", "심부름"]
    let titleArray: [String] = ["EZY 회의", "디자인 이론 공부", "강아지 산책시키기", "카페에서 마카롱 사오기", "EZY 회의", "디자인 이론 공부", "강아지 산책시키기", "카페에서 마카롱 사오기"]
    let planTimeArray: [String] = ["12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00"]
    var labelArr = ["나의 할 일","우리의 할 일","심부름","문의하기"]
```

##### 5. TableViewCell별 색을 지정해주기 위해 변수에 색을 저장했다!
```Swift
    var purpleColor: UIColor! = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
    var orangeColor: UIColor! = UIColor(red: 255/255, green: 166/255, blue: 128/255, alpha: 1)
    var yellowColor: UIColor! = UIColor(red: 255/255, green: 209/255, blue: 141/255, alpha: 1)
    var greenColor: UIColor! = UIColor(red: 184/255, green: 128/255, blue: 255/255, alpha: 1)

     lazy var EZYPlanBackgroundColor: [UIColor] = [purpleColor, orangeColor, yellowColor, greenColor, purpleColor, orangeColor, yellowColor, greenColor]
```
##### 6. TableView delegate, dateSource self 지정하기
- ###### tableView에 데이터를 넣고, dataSource와 tableView의 이벤트(셀 터치 등) 및 레이아웃 작업를 처리하기 위해서는 self로 지정해줘야합니다.

```Swift
   EZYLISTTableView.delegate = self
   EZYLISTTableView.dataSource = self
```

##### 7. TableView의 cell을 구분해주는 선을 제거하기
- ###### TableViewCell을 다양하게 Custom하다 보면, 기본적으로 구분되어있는 선이 거슬릴 때가 있다!<br>그럴땐 separatorStyle을 .none으로 지정해주자
```Swift
        self.EZYLISTTableView.separatorStyle = .none
```

##### 8. TableView를 addSubView해주자
- ###### addSubView는 addChildView와 다르게 하나의 ViewController(즉, addSubView 코드를 친 ViewController)에서 addSubView된 뷰들의 Event를 모두 담당한다.
```Swift
self.view.addSubview(EZYLISTTableView)
```

##### 9. TableView의 ScrollBar?를 없애보자!
- ###### TableView를 Scroll하면 오른쪽에 표시되는 긴 회색 바를 지우고싶을 수 있다.<br>그럴 때는 showsVerticalScrollIndicator를 false로 지정해주자
```Swift
        EZYLISTTableView.showsVerticalScrollIndicator = false
```

##### 10. 이제 TableView와 TableViewCell을 연결해주자!
- ###### EZYLISTTableViewCell.swift파일을 만들고 EZYLISTTableViewCell Class를 선언한 뒤 연결해보자!
```Swift
        EZYLISTTableView.register(EZYLISTTableViewCell.classForCoder(), forCellReuseIdentifier: "EZYLISTTableViewCell")
```

##### 11. TableView의 layout을 지정해보자~
- ##### layout은 SnapKit을 사용하여 지정해주고, ViewDidLoad에서 이 함수를 call해주자
```Swift
    func EZYLISTTableViewSnapKit(){
        EZYLISTTableView.snp.makeConstraints { make in
            make.top.equalTo(EZYLISTHeaderView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
```

#### 이제! TableView의 Protocol을 준수해보자!
##### 12. TableViewDelegate!
###### 규칙을 지켜보자~규칙을 지켜보자~ 먼저 TableViewDelegate를 채택해보자<br> extension을 통해 나중에 코드가 복잡해질 때를 대비하자!

```Swift
extension EZYMainViewController: UITableViewDelegate{

}
```
- ###### TableViewDelegate프로토콜은 무조건 준수해야하는 규칙이 없다.<br>따라서 필요에 따라 생성되어있는 TableView함수들을 가져다 써보자!
###### 나는 Cell클릭시 실행되는 method를 가져다 썼다.
###### 사용자가 Cell 클릭 시 didSelectRowAt함수가 실행되고, 화면전환이 되도록 구현했다.

```Swift
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView - didSelectRowAt")
        let pushVC = NextViewController()
        
        pushVC.titleLabel.text = titleArray[indexPath.row]
        
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
```

##### 13. 다음으로 TableViewDataSource를 채택해보자
###### TableViewDataSource는 delegate와 다르게 필수로 구현해줘야하는 method가 2개가 있다!
- ###### numberOfRowsInSection : Cell 몇 개 만들 거냐
- ###### cellForRowAt : Cell에 뭐 넣을거냐
```Swift
extension EZYMainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     }
}
```
- ##### numberOfRowsInSection! Cell 몇 개 만들 거냐
###### 위에 선언했던 그룹이름 개수만큼 Cell을 만들기로했어요 
```Swift
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNameArray.count
    }
```

- ##### cellForRowAt! Cell에 어떤 걸 넣을거냐~

```Swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EZYLISTTableViewCell", for: indexPath) as! EZYLISTTableViewCell
        cell.groupNameLabel?.text = groupNameArray[indexPath.row]
        cell.titleLabel?.text = titleArray[indexPath.row]
        cell.planTimeLabel?.text = planTimeArray[indexPath.row]
        
        cell.EZYLISTCellLeftDecorationView.backgroundColor = EZYPlanBackgroundColor[indexPath.row]
        cell.titleLabel.textColor = EZYPlanBackgroundColor[indexPath.row]
        cell.groupNameLabel.textColor = EZYPlanBackgroundColor[indexPath.row]
        
        print("tableView - cellForRowAt")
        print(indexPath.row)
        print(cell.titleLabel!.text ?? "")
        
        cell.backgroundColor = .white
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                
        return cell
    }
```






