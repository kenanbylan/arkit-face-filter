//
//  TableViewController.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 27.12.2022.
//

import UIKit

class TableViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var specialArray  = ["Nose","Hair","Mouth","Eye"]
    var selectFilterName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSceneView" {
            //let destinationVC = segue.destination
            if  let destinationVC = segue.destination as? FilterVC {
                print("destination vc :",destinationVC)
                destinationVC.filterName = selectFilterName
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectFilterName = specialArray[indexPath.row]
        
        self.performSegue(withIdentifier:"toSceneView" , sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = specialArray[indexPath.row]
        return cell
        
    }
    
    
    
    
}
