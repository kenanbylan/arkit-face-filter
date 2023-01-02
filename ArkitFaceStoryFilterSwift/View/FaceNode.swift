import SceneKit

class FaceNode: SCNNode {
    
    var node: Node
    var index = 0
    
    init(with node: Node, width: CGFloat = 0.06, height: CGFloat = 0.06) {
        self.node = node
        
        super.init()
        
        let plane = SCNPlane(width: width, height: height)
        plane.firstMaterial?.diffuse.contents =  self.node.image
        plane.firstMaterial?.isDoubleSided = true
        
        geometry = plane
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}


extension FaceNode {
    
    
    func updatePosition(for vectors: [vector_float3]) {
        let newPos = vectors.reduce(vector_float3(), +) / Float(vectors.count)
        position = SCNVector3(newPos)
    }
    
    
    //clicked
    func change(node: Node) {
        self.node = node
        if let plane = geometry as? SCNPlane {
            plane.firstMaterial?.diffuse.contents = self.node.image
            plane.firstMaterial?.isDoubleSided = true
        }
    }
}
