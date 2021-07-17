# MVC with Model

* ## iOS Architecture Patterns

* #### MVCwithViewController.swift - Controller
```swift
//
//  MVCwithModelViewController.swift
//  MVC
//
//  Created by 김유진 on 2021/04/25.
//

import UIKit
import Alamofire

class MVCwithModelViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APICall()
    }
    
    var responseArray = [DataModel]()
    
    func APICall(){
        AF.request(URL(string: "https://jsonplaceholder.typicode.com/posts")!, method: .get, parameters: nil, headers: nil).responseJSON { (response) in
            if let responseData = response.data{
                do{
                    let decodeJson = JSONDecoder()
                    decodeJson.keyDecodingStrategy = .convertFromSnakeCase
                    self.responseArray = try decodeJson.decode([DataModel].self, from: responseData)
                    self.tableView.reloadData()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }

}

extension MVCwithModelViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = String(responseArray[indexPath.row].id ?? 0)
        cell.detailTextLabel?.text = responseArray[indexPath.row].title
        
        return cell
    }
    
}

```

* #### DataModel.swift - Model
```swift
//
//  DataModel.swift
//  MVC
//
//  Created by 김유진 on 2021/04/24.
//

import Foundation

class DataModel: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}

```

* #### MVCwithModelViewControllerTableViewCell.swift - Model
```swift
//
//  MVCwithModelViewControllerTableViewCell.swift
//  MVC
//
//  Created by 김유진 on 2021/04/25.
//

import UIKit

class MVCwithModelViewControllerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
```