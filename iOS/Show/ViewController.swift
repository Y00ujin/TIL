import UIKit

class ViewController: UIViewController {
    
    let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    @IBOutlet weak var goA: UIButton!
    @IBOutlet weak var goB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goA(_ sender: Any) {
        let aController = myStoryBoard.instantiateViewController(identifier: "A")
        
        self.show(aController, sender: self)
    }
    
    @IBAction func goB(_ sender: Any) {
        let bController = myStoryBoard.instantiateViewController(identifier: "B")
        
        self.show(bController, sender: self)
    }
}