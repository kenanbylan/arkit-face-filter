import UIKit
import Firebase
import SDWebImage

class DiscoverVC: UIViewController , UITableViewDelegate,  UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let fireStoreDb = Firestore.firestore()
    var postArray = [Post]()
    var choosenPost : Post?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
            
        getUserInfo()
        
        getSnapsData()
        
    }
    
    
    func getSnapsData(){
        
        fireStoreDb.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.postArray.removeAll(keepingCapacity: false)

                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour  {
                                        
                                        if difference >= 24 {
                                            self.fireStoreDb.collection("Snaps").document(documentId).delete()
                                        } else {
                                            let snap = Post(username: username, imageUrlArray: imageUrlArray)
                                            self.postArray.append(snap)
                                        }
                                        
                                      
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
            }
        }
        
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
        cell.usernameLabel.text = postArray[indexPath.row].username
        cell.imageViewCell.sd_setImage(with: URL(string: postArray[indexPath.row].imageUrlArray[postArray[indexPath.row].index]))
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DiscoverCell else {
            return
        }
        
        postArray[indexPath.row].index = postArray[indexPath.row].index == postArray[indexPath.row].imageUrlArray.count-1 ? 0 : postArray[indexPath.row].index+1
        
        cell.imageViewCell.sd_setImage(with: URL(string: postArray[indexPath.row].imageUrlArray[postArray[indexPath.row].index]))
    }
    
    func makeAlert(title:String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
    
    
    
    
}
