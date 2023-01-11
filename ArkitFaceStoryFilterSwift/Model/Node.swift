//
//  Node.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 28.12.2022.
//

import Foundation
import UIKit

struct Node {
    let name: String
    let vertex: [Int]
    let image: UIImage
    let size: CGFloat
}

let nodes = [
    Node(name: "eye", vertex: [1064], image: UIImage(named: "eye")!, size: 0.06),
    Node(name: "heart", vertex: [600], image: UIImage(named: "heart")!, size: 0.03),
    Node(name: "nose01", vertex: [6], image: UIImage(named: "nose01")!, size: 0.06),
    Node(name: "nose02", vertex: [6], image: UIImage(named: "nose02")!, size: 0.06),
    Node(name: "nose03", vertex: [6], image: UIImage(named: "nose03")!, size: 0.06),
    Node(name: "nose04", vertex: [6], image: UIImage(named: "nose04")!, size: 0.06),
    Node(name: "nose05", vertex: [6], image: UIImage(named: "nose05")!, size: 0.06),
    Node(name: "nose06", vertex: [6], image: UIImage(named: "nose06")!, size: 0.06),
    Node(name: "nose07", vertex: [6], image: UIImage(named: "nose07")!, size: 0.06),
    Node(name: "nose08", vertex: [6], image: UIImage(named: "nose08")!, size: 0.06),
    Node(name: "nose09", vertex: [6], image: UIImage(named: "nose09")!, size: 0.06),
    Node(name: "mouth01", vertex: [25,24], image: UIImage(named: "mouth01")!, size: 0.06),
    Node(name: "hat", vertex: [20], image: UIImage(named: "hat")!, size: 0.2),
]
