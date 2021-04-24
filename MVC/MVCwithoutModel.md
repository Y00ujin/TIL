## MVC without Model

* ### iOS Architecture Patterns

* #### ViewController.swift
```swift
//
//  ViewController.swift
//  MVC
//
//  Created by 김유진 on 2021/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    let person = Person(name: "Youjin", gender: "women", age: 18, weight: 53, height: 165)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let myView = ExampleView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        
        myView.center = view.center
        
        myView.configure(with: "\(person.name)")
        
        view.addSubview(myView)
    }
    
}

struct Person{
    let name: String
    let gender: String
    let age: Int
    let weight: Double
    let height: Double
}

struct Location {
    let city: String
}
```

---

* #### ExampleView.swift
```swift
//
//  ExampleView.swift
//  MVC
//
//  Created by 김유진 on 2021/04/24.
//

import UIKit

class ExampleView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {     
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with name: String){
        label.text = name 
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(
            x: 10,
            y: 10,
            width: frame.size.width - 20,
            height: frame.size.height - 20
        )
    }
}

```