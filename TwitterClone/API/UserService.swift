//
//  UserService.swift
//  TwitterClone
//
//  Created by Galih Asmarandaru on 20/10/20.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        USERS_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            print(dictionary)
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
}
