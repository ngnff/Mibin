//
//  SignManager.swift
//  Mibin
//
//  Created by Слава on 29.05.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
    }
}



struct userAccount: Codable{
    var uid: String
    var email: String
    var username: String
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init(){
        
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String, userName: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        let ref = Database.database().reference()
        let user = userAccount(uid: authDataResult.user.uid, email: email, username: userName)
        do {
                    let userData = try JSONEncoder().encode(user)
                    let userDictionary = try JSONSerialization.jsonObject(with: userData, options: []) as? [String: Any]
                    
                    ref.child("users").child(authDataResult.user.uid).setValue(userDictionary) { error, _ in
                        if let error = error {
                            print("Error saving data: \(error.localizedDescription)")
                        } else {
                            print("Data saved successfully!")
                        }
                    }
                } catch {
                    print("Error encoding user data: \(error.localizedDescription)")
                }
        
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
