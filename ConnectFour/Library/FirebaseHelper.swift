//
//  FirebaseHelper.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/16/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class FirebaseHelper {
    
    static func configure() {
        FirebaseApp.configure()
    }
    
    static func start(game: CFGame) {
        var dictionary = [String: Any]()
//        dictionary[firKey(.type)] = message.type.rawValue
//        dictionary[firKey(.timeout)] = message.timeout
//        dictionary[firKey(.waitTime)] = message.waitTime
//        dictionary[firKey(.action)] = message.action.rawValue
//        dictionary[firKey(.needAnswer)] = message.needAnswer
        
        let database = Database.database().reference()
        
        // replace value in Database
        database.child(firKey(.game)).child("\(game.id)").setValue(dictionary)
    }
    
    static func game(_ completion:@escaping () -> Void) {
        let database = Database.database().reference()
        _ = database.observe(.value, with: { (snapshot) in
            
//            var messages = [Message]()
//
//            for child in snapshot.children {
//                if let messagesSnapshot = child as? DataSnapshot {
//                    for child in messagesSnapshot.children {
//                        if let messageSnapshot = child as? DataSnapshot {
//                            var messageObj = Message()
//
//                            messageObj.id = messageSnapshot.key
//                            messageObj.type = firKeyValue(messageSnapshot, key: .type)
//                            messageObj.message = stringValue(messageSnapshot, key: .message)
//                            messageObj.date = stringValue(messageSnapshot, key: .date)
//                            messageObj.imageUrl = stringValue(messageSnapshot, key: .imageUrl)
//                            messageObj.read = boolValue(messageSnapshot, key: .read)
//                            messageObj.readAt = stringValue(messageSnapshot, key: .readAt)
//                            messageObj.timeout = doubleValue(messageSnapshot, key: .timeout)
//                            messageObj.waitTime = doubleValue(messageSnapshot, key: .waitTime)
//                            messageObj.answer = stringValue(messageSnapshot, key: .answer)
//                            messageObj.needAnswer = boolValue(messageSnapshot, key: .needAnswer)
//                            messageObj.action = firActionValue(messageSnapshot, key: .action)
//                            messageObj.action1 = stringValue(messageSnapshot, key: .action1)
//                            messageObj.action2 = stringValue(messageSnapshot, key: .action2)
//
//                            messages.append(messageObj)
//                        }
//                    }
//                }
//            }
            
            completion()
        })
    }
}

// MARK: - Enumerators
    
extension FirebaseHelper {
    static func firKey(_ type: FirebaseKey) -> String {
        return type.rawValue
    }
}

enum FirebaseKey: String {
    case game
    case player
}
