
import UIKit
import FirebaseAuth
import Firebase


class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        
        if emailTextField.text != nil  && passwordTextField.text != nil {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }
                self.performSegue(withIdentifier: "toTableView", sender: nil)
            }
        }else {
            self.makeAlert(title: "Error", message: "Email or Password is Empty.")
        }
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
        
        if emailTextField.text != nil  && passwordTextField.text != nil {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    
    func makeAlert(title:String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
}
