//
//  SettingsVC.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 27.12.2022.


import UIKit
import FirebaseAuth
class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        usernameLabel.text = "test"
        emailLabel.text = "testing"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLoginVC", sender: nil)
            
        } catch {
            print(error)
        }
        
    }
    
}
