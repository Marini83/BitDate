//
//  User.swift
//  BitDate
//
//  Created by User  on 2015-09-04.
//  Copyright (c) 2015 Wub.com. All rights reserved.
//

import Foundation


struct User {
    let id: String
    let name: String
    private let pfUser: PFUser
    
    func getPhoto(callback:(UIImage) -> ()) {
        let imageFile = pfUser.objectForKey("picture") as! PFFile
        imageFile.getDataInBackgroundWithBlock({
            data, error in
            if let data = data {
                callback(UIImage(data: data)!)
            }
        })
    }
    
}

private func pfUserToUser(user: PFUser)->User {
    return User(id: user.objectId!,  name: user.objectForKey("firstName") as! String, pfUser: user)
}

func currentUser() -> User? {
    if let user = PFUser.currentUser() {
        return pfUserToUser(user)
    }
    return nil
}