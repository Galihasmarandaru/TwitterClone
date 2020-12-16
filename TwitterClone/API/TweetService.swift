//
//  TweetService.swift
//  TwitterClone
//
//  Created by Galih Asmarandaru on 22/10/20.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let  uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caption] as [String: Any]
        
        let ref = TWEETS_REF.childByAutoId()
        
//        TWEETS_REF.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        ref.updateChildValues(values) { (err, ref) in
            // update user-tweet structure after tweet upload complete
            guard let tweetID = ref.key else { return }
            USER_TWEETS_REF.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
        }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        TWEETS_REF.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
            
//            let tweet = Tweet(tweetID: tweetID, dictionary: dictionary)
//            tweets.append(tweet)
//            completion(tweets)
            
//            UserService.shared.fetchUser(completion: <#T##(User) -> Void#>)
        }
    }
    
    func fetchTweets(forUser user: User, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        USER_TWEETS_REF.child(user.uid).observe(.childAdded) { snapshot in
            let tweetID = snapshot.key
            
            TWEETS_REF.child(tweetID).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                
                UserService.shared.fetchUser(uid: uid) { user in
                    let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
}
