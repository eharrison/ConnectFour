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
    
    static func handleTurn(game: CFGame?, statusMatrix: [[GameBoardPlayer]], player: GameBoardPlayer, winner: GameBoardPlayer?) {
        var dictionary = [String: Any]()
        dictionary[firKey(.currentTurn)] = player == .player1 ? GameBoardPlayer.player2.rawValue : GameBoardPlayer.player1.rawValue
        dictionary[firKey(.winner)] = winner
        
        // convert status matrix to dictionary
        dictionary[firKey(.statusMatrix)] = convertToDictionary(statusMatrix: statusMatrix)
        
        let database = Database.database().reference()
        
        // replace value in Database
        database.child(firKey(.game)).child("\(game?.id ?? 0)").setValue(dictionary)
    }
    
    static func game(game: CFGame?, completion:@escaping (_ statusMatrix: [[GameBoardPlayer]], _ currentTurn: GameBoardPlayer, _ winner: GameBoardPlayer?) -> Void) {
        guard let game = game else {
            return
        }
        
        let database = Database.database().reference()
        _ = database.observe(.value, with: { (snapshot) in

            for child in snapshot.children {
                if let gameSnapshot = child as? DataSnapshot {
                    for child in gameSnapshot.children {
                        if let gameData = child as? DataSnapshot {
                            let currentTurn = GameBoardPlayer(rawValue: intValue(gameData, key: .currentTurn)) ?? .empty
                            
                            var winner: GameBoardPlayer?
                            if gameData.hasChild(firKey(.winner)) {
                                winner = GameBoardPlayer(rawValue: intValue(gameData, key: .winner))
                            }
                            
                            // convert status matrix back
                            let statusMatrix = self.statusMatrix(game: game, gameData: gameData)
                            
                            completion(statusMatrix, currentTurn, winner)
                        }
                    }
                }
            }
        })
    }
}

// MARK: - Formaters

extension FirebaseHelper {
    
    static func stringValue(_ from: DataSnapshot, key: FirebaseKey) -> String? {
        if let value = from.childSnapshot(forPath: firKey(key)).value as? String {
            return value
        }
        
        return nil
    }
    
    static func boolValue(_ from: DataSnapshot, key: FirebaseKey) -> Bool {
        if let value = from.childSnapshot(forPath: firKey(key)).value as? Bool {
            return value
        }
        
        return false
    }
    
    static func doubleValue(_ from: DataSnapshot, key: FirebaseKey) -> Double {
        if let value = from.childSnapshot(forPath: firKey(key)).value as? Double {
            return value
        }
        
        return 0
    }
    
    static func intValue(_ from: DataSnapshot, key: FirebaseKey) -> Int {
        if let value = from.childSnapshot(forPath: firKey(key)).value as? Int {
            return value
        }
        
        return 0
    }
    
    static func convertToDictionary(statusMatrix: [[GameBoardPlayer]]) -> [String: Any] {
        var matrixDictionary = [String: Any]()
        for (column, rowArray) in statusMatrix.enumerated() {
            for (row, rowElement) in rowArray.enumerated() {
                var elementDictionary = [String: Any]()
                elementDictionary[firKey(.status)] = rowElement.rawValue
                elementDictionary[firKey(.column)] = column
                elementDictionary[firKey(.row)] = row
                
                matrixDictionary["\(column)-\(row)"] = elementDictionary
            }
        }
        
        return matrixDictionary
    }
    
    static func statusMatrix(game: CFGame, gameData: DataSnapshot) -> [[GameBoardPlayer]] {
        var statusMatrix = ConnectFourGameManager.cleanStatusMatrix(game: game)
        
        if let statusMatrixDictionary = gameData.childSnapshot(forPath: firKey(.statusMatrix)).value as? [String: Any] {
            for key in statusMatrixDictionary.keys {
                if let dictionary = statusMatrixDictionary[key] as? [String: Any] {
                    let column = (dictionary[firKey(.column)] as? Int) ?? 0
                    let row = (dictionary[firKey(.row)] as? Int) ?? 0
                    let status = GameBoardPlayer(rawValue: (dictionary[firKey(.status)] as? Int) ?? 0) ?? .empty
                    
                    statusMatrix[column][row] = status
                }
            }
        }
        
        return statusMatrix
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
    case winner
    case currentTurn
    case statusMatrix
    case column
    case row
    case status
}
