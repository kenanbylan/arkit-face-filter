import SceneKit
import ARKit

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
    
    
    func updatePosition(anchor: ARFaceAnchor) {
        let vertices = [anchor.geometry.vertices[node.vertex[0]]]
        var newPos = vertices.reduce(vector_float3(), +) / Float(vertices.count)
        if node.name == "hat" {
            newPos.y += 0.1
        }
        position = SCNVector3(newPos)
    }
    
    
    //clicked
    func change(node: Node) {
        self.node = node
        if let plane = geometry as? SCNPlane {
            plane.firstMaterial?.diffuse.contents = self.node.image
            plane.firstMaterial?.isDoubleSided = true
            plane.height = self.node.size
            plane.width = self.node.size
        }
    }
}
