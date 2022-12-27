//
//  SettingsVC.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 27.12.2022.
//

import UIKit
import FirebaseAuth
class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
