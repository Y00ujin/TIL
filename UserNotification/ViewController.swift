//
//  ViewController.swift
//  UserNotifications
//
//  Created by 김유진 on 2021/05/17.
//

import UIKit
import UserNotifications
import SnapKit

class ViewController: UIViewController {
    
    var tableView: UITableView = {
        var tableView = UITableView()
       return tableView
    }()
    
    var models = [MyReminder]()
    
    var addButton: UIButton = {
        let button   = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.setImage(UIImage(systemName: "folder"), for: .normal)
        button.tintColor = .darkGray
        
        return button
    }()
    
    var testButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "doc.append"), for: .normal)
        button.tintColor = .darkGray
        
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        self.view.addSubview(addButton)
        self.view.addSubview(testButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableViewCell.classForCoder(), forCellReuseIdentifier: "TableViewCell")
        
        addButton.addTarget(self, action: #selector(addButtonSelected), for: .touchUpInside)
        testButton.addTarget(self, action: #selector(testButtonSelected), for: .touchUpInside)
        
        tableViewSnapKit()
        addButtonSnapKit()
        testButtonSnapKit()
    }
    
    @objc func addButtonSelected(_ sender: AnyObject){
        print("ViewController - addButtonSelected")
    }
    
    @objc func testButtonSelected(_ sender: AnyObject){
        print("ViewController - testButtonSelected")
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound], completionHandler: { success, error in
            if success {
                self.scheduleTest()
            }else if let error = error {
                print("error occurred")
            }
        })
    }
    
    func scheduleTest(){
        let content = UNMutableNotificationContent()
        content.title = "This is title"
        content.sound = .default
        content.body = "This is boooooooooooooooody"
        
        let targetDate = Date().addingTimeInterval(5)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil{
                print("something went wrong")
            }
        })
    }
    
    func addButtonSnapKit(){
        addButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview()
            make.height.width.equalTo(70)
        }
    }
    
    func testButtonSnapKit(){
        testButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.height.width.equalTo(70)
        }
    }
    
    func tableViewSnapKit(){
        tableView.snp.makeConstraints { make in
            make.top.equalTo(testButton.snp.bottom)
            make.bottom.right.left.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.textLabel!.text = models[indexPath.row].title
        
        return cell
    }
}

struct MyReminder {
    let title: String
    let data: Date
    let identifier: String
}


