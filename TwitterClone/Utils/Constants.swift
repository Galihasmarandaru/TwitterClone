//
//  Constants.swift
//  TwitterClone
//
//  Created by Galih Asmarandaru on 17/10/20.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGE_REF = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let USERS_REF = DB_REF.child("users")
let TWEETS_REF = DB_REF.child("tweets")
let USER_TWEETS_REF = DB_REF.child("user-tweets")
