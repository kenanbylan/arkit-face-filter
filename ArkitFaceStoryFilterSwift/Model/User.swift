//
//  User.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 24.12.2022.
//

import Foundation

class UserSignleton {
    
    static let sharedUserInfo = UserSignleton()
    var email = ""
    var password = ""
    private init(){
        
    }
    
}

