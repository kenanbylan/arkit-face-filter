//
//  FilterVC.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 27.12.2022.

import UIKit
import SceneKit
import ARKit
import SpriteKit

class FilterVC: UIViewController   ,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var filterName = ""  //table sayfasından seçilen yüz noktası.
    
    
    
    let noseOptions = ["nose01", "nose02", "nose03", "nose04", "nose05", "nose06", "nose07", "nose08", "nose09"]
    let features = ["nose"]
    var featureIndices = [[6]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.isUserInteractionEnabled = true //tiklanabilir yaptik.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tap)
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem =  UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem =  UIBarButtonItem(title: "Save Photo", style: .plain, target: self, action: #selector(savePhoto))
        
        
        print("Secilen yüz noktası  :" , filterName)
        
        
        
    }
    
    
    @objc func back(){
        //refresh
        self.dismiss(animated: true)
        print("refresh")
    }
    
    @objc func savePhoto(){
        //savePhoto
        print("save ")
        // self.dismiss(animated: true)
    }
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        print("clicked.")
        
        let location = sender!.location(in: sceneView)
        let results = sceneView.hitTest(location, options: nil)
        if let result = results.first,
           let node = result.node as? FaceNode {
            node.next()
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuratio = ARFaceTrackingConfiguration()
        
        sceneView.session.run(configuratio)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    
    
    /*
     @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
     let location = sender.location(in: sceneView)
     let results = sceneView.hitTest(location, options: nil)
     if let result = results.first,
     let node = result.node as? FaceNode {
     node.next()
     }
     }
     */
    
    
    
    
    func updateFeatures(for node: SCNNode, using anchor: ARFaceAnchor) {
        print(featureIndices)
        for (feature, indices) in zip(features, featureIndices) {
            let child = node.childNode(withName: feature, recursively: false) as? FaceNode
            let vertices = indices.map { anchor.geometry.vertices[$0] }
            child?.updatePosition(for: vertices)
        }
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
        
        let noseNode = FaceNode(with: noseOptions)
        noseNode.name = "nose"
        node.addChildNode(noseNode)
        
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
