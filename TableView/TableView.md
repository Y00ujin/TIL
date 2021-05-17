# **UITableView**

- #### **EZYLIST 구현해보기 with Code** 👩🏻‍💻

<br>

##### **🛠 TableView 를 위한 Protocol**
***
###### UITableView 를 위한 Protocol 은 **UITableViewDataSource**, **UITableViewDelegate** 가 있다. <br> 여기서 Protocol 은 TableView를 이용하기 위해 해야할 일들의 목록, 즉 구현해야할 method 들이다. 

<br>

- ###### ```protocol``` 준수는 클래스간 상속을 하듯이 작성해줘도 되지만,

```Swift
class EZYLISTViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
}
```

- ###### 나중에 코드가 많아 복잡해질 경우를 위해 ```extension```을 통해 따로 빼줘도 된다.
```Swift
extension EZYLISTViewController: UITableViewDataSource{
}

extension EZYLISTViewController: UITableViewDelegate{
    
}
```


<br>

##### **🛠 UITableViewDataSource**

***

##### TableView 를 이용하기 위해서 UITableViewDataSource에서 필수로 구현해야 하는 method 가 있다.

```Swift
extension EZYLISTViewController: UITableViewDataSource{
}
```

- ###### TableView 의 cell 이 몇개인지?
- ###### Table view 를 어떻게 보여줄 것인지?
 - ###### ```UITableViewDataSource protocol``` 의 경우, 필수 구현 함수를 추가하지 않으면, 에러가 발생한다. <br>Fix 를 누르면 자동으로 추가해준다.

<br>

###### 해당 질문은 다음 method 를 구현함으로 답변할 수 있다.

<br>

##### **1. tableView(_:numberOfRowsInSection:)**

```Swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

- ###### 특정 section 에 표시할 row 의 개수를 묻는 method
- ###### return 값으로 몇 개의 셀을 보여줄지에 대한 답변을 구현하면 된다. 
- ###### section 에 따라 다른 셀의 개수를 반환하도록 구현할 수 있다. 

<br>

##### **2. tableView(_:cellForRowAt:)**

```Swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

- ###### 특정 위치에 표시할 cell 을 요청하는 method
- ###### cell 을 생성할 때, custom cell 을 재사용하려면 dequeueReusableCell(withIdentifier:for:) method 를 이용한다.
- ###### cell 을 만든 후에, data 값들을 통해 cell 의 속성들을 업데이트할 수 있다.
- ###### return 값으로 UITableViewCell 을 상속받은 object 를 반환해야 한다. (nil 반환시 에러 발생)


<br>

##### **🛠 UITableViewDelegate**

***

###### Table view delegate object는 해당 프로토콜을 채택한다. <br> Table view 내에 클릭된 셀을 매니징하거나, 섹션의 header와 footer 설정, 셀을 삭제하거나 재졍럴하기 위해 이용한다.

<br>

```Swift
extension EZYLISTViewController: UITableViewDelegate{
    
}
```

- ###### custom header 와 footer view 를 만들고 관리하는 것
- ###### row, header, footer 의 높이를 지정하는 것
- ###### 더 나은 스크롤 지원을 위해 높이의 추정치를 제공하는 것
- ###### row 의 들여쓰기 수준을 지정하는 것
- ###### 선택된 row 에 대해 응답하는 것
- ###### table row 를 스와이프하는 등 액션에 응답하는 것
- ###### table content 를 편집할 수 있도록 지원하는 것

<br>

###### ```UITableViewDelegate protocol``` 필수 구현 method 가 없다. 다음은 주로 작성했던 method 이다.

<br>
 
##### **1. tableView(_didSelectRowAt:)** 
```Swift
optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
```

- ###### delegate (대리인)에게 row가 선택되었음을 알려주는 함수. 
- ###### 셀을 선택했을 때 어떻게 할지에 대해 구현할 수 있는 함수이다.

<br>

###### 예시로, ```TableView``` 가 ```List page``` 이고 ```Detail page``` 가 있다면 해당 ```method``` 에서 ```performSegue``` 를 호출해 ```Detail page``` 로 넘어가는 코드를 작성할 수 있다.

```Swift
extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}
```


<br>

##### **🛠 개발 시작**

***

