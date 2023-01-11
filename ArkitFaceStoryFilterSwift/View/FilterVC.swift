//
//  FilterVC.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 27.12.2022.

import UIKit
import SceneKit
import ARKit
import Firebase
import FirebaseStorage


class FilterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var collectionView: UICollectionView!
    var filterName: String? = nil  //table sayfasından seçilen yüz noktası.
    
    var node = FaceNode(with: nodes[0])
    
    var featureIndices = [[6]]  //for nose
    
    
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.register(FilterCollectionViewCell.nib(), forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sceneView.delegate = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem =  UIBarButtonItem(title: "Save Photo", style: .plain, target: self, action: #selector(savePhoto))
    }
    
    
    
    @objc func savePhoto(){
        //savePhoto
        print("add photo and select index = 0.")
        
        image  = sceneView.snapshot()
        
        uploadFirebase()
        
    }
    
    
    func uploadFirebase(){
        
        
        let storage = Storage.storage()
        let storageReference = storage.reference() //?
        let mediaFolder = storageReference.child("media")
        
        if let data = image.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data,metadata: nil) { metaData, error in
                
                if error != nil {
                    self.makeAlert(title: "Error!!!", message: error?.localizedDescription ?? "Error!")
                } else {
                    
                    imageReference.downloadURL { url, error in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            //Firestore Processing
                            let fireStore = Firestore.firestore()
                            
                            
                            fireStore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSignleton.sharedUserInfo.username).getDocuments { snapshot, error in
                                
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error Localize")
                                } else {
                                    
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        
                                        for document in snapshot!.documents {
                                            
                                            let documentId = document.documentID
                                            
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                                
                                                imageUrlArray.append(imageUrl!)
                                                
                                                let additionalDictionary = ["imageUrlArray" : imageUrlArray] as? [String:Any]
                                                
                                                
                                                fireStore.collection("Snaps").document(documentId).setData(additionalDictionary!, merge: true) { error in
                                                    
                                                    if error == nil {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.image = UIImage(systemName:"plus.square.fill.on.square.fill")!
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        
                                    } else {
                                        
                                        let snapDictionary = ["imageUrlArray" : [imageUrl!], "snapOwner" : UserSignleton.sharedUserInfo.username , "date" : FieldValue.serverTimestamp()   ] as [String : Any]
                                        
                                        fireStore.collection("Snaps").addDocument(data: snapDictionary) { error in
                                            
                                            if error != nil {
                                                self.makeAlert(title: "Error", message:error?.localizedDescription ?? "Error")
                                            } else {
                                                
                                                self.tabBarController?.selectedIndex = 0
                                                self.image = UIImage(systemName:"plus.square.fill.on.square.fill")!
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.delegate = self
        
        let configuratio = ARFaceTrackingConfiguration()
        
        sceneView.session.run(configuratio)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func updateFeatures(for node: SCNNode, using anchor: ARFaceAnchor) {
        let child = node.childNode(withName: "node", recursively: false) as? FaceNode
        child?.updatePosition(anchor: anchor)
    }
    
    
    func makeAlert(title:String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
}

extension FilterVC: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let device: MTLDevice!
        device = MTLCreateSystemDefaultDevice()
        
        
        //face anchor done.
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return nil
        }
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        //node.geometry?.firstMaterial?.transparency = 0.0
        
        self.node.name = "node"
        node.addChildNode(self.node)
        
        updateFeatures(for: node, using: faceAnchor)
        
        return node
    }
    
    func renderer(
        _ renderer: SCNSceneRenderer,
        didUpdate node: SCNNode,
        for anchor: ARAnchor) {
            guard let faceAnchor = anchor as? ARFaceAnchor,
                  let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
                return
            }
            
            faceGeometry.update(from: faceAnchor.geometry)
            updateFeatures(for: node, using: faceAnchor)
        }
    
    
}

extension FilterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.node.change(node: nodes[indexPath.row])
    }
}

extension FilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
        cell.configure(with: nodes[indexPath.row].image)
        return cell
    }
    
    
}
