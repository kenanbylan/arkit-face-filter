import UIKit
import Firebase


class DiscoverVC: UIViewController , UITableViewDelegate,  UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let fireStoreDb = Firestore.firestore()
    var snapArray = [Post]()
    var choosenPost : Post?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
            
        getUserInfo()
        
    }
    
    
    func getUserInfo(){
        
        fireStoreDb.collection("UserData").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshots, error in
            
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }
            
            if snapshots?.isEmpty == false && snapshots != nil {
                //self.snapArray.removeAll()
                for document in snapshots!.documents {
                    if let username = document.get("username") as? String {
                        
                        UserSignleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                        UserSignleton.sharedUserInfo.username = username
                        
                    }
                }
            }
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoverCell", for: indexPath) as! DiscoverCell
        cell.usernameLabel.text = "Kenan Baylan"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func makeAlert(title:String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
    
    
    
    
}
