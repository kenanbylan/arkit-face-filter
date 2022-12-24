//
//  LoginVC.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 22.12.2022.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
      
        
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        
        if usernameTextField.text != nil  && passwordTextField.text != nil {
            
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { result, error in
                
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
        if usernameTextField.text != nil  && passwordTextField.text != nil {
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!)
        }
        
        
    }
    
    
    func makeAlert(title:String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
}
