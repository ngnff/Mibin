//
//  Model.swift
//  Mibin
//
//  Created by Слава on 20.05.2024.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

struct Model: Identifiable{
    
    let id = UUID().uuidString
    
    var country: String
    var city: String
    var street: String
    var house: String
    var status: String
    var description: String
    var imageUrl: String
    var createdBy: String
    var creatorId: String
    
    init(country: String, city: String, street: String, house: String, status: String, description: String, imageUrl: String, createdBy: String, creatorId: String)
    {
        self.country = country
        self.city = city
        self.street = street
        self.house = house
        self.status = status
        self.description = description
        self.imageUrl = imageUrl
        self.createdBy = createdBy
        self.creatorId = creatorId
    }
    
    init(data: [String: Any]) {
        self.country = data["country"] as? String ?? ""
        self.city = data["city"] as? String ?? ""
        self.street = data["street"] as? String ?? ""
        self.house = data["house"] as? String ?? ""
        self.status = data["status"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.createdBy = data["createdBy"] as? String ?? ""
        self.creatorId = data["creatorId"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "id": id,
                "country": country,
                "city": city,
                "street": street,
                "house": house,
                "status": status,
                "description": description,
                "imageUrl": imageUrl,
                "createdBy": createdBy,
                "creatorId": creatorId
            ]
        }
}

class TrashCardViewModel: ObservableObject {
    @Published var trashCards: [Model] = []
    @Published var name: String = ""
    @Published var email: String = ""
    
    private var usersRef: DatabaseReference!
    private var databaseRef: DatabaseReference!
    
    init() {
        usersRef = Database.database().reference().child("users")
        databaseRef = Database.database().reference().child("trashCards")
        fetchTrashCards()
        fetchUserData()
    }
    
    func fetchUserData() {
            let currentUserID = Auth.auth().currentUser?.uid ?? ""
            
            usersRef.child(currentUserID).observeSingleEvent(of: .value) { snapshot in
                if let userData = snapshot.value as? [String: Any] {
                    self.name = userData["username"] as? String ?? ""
                    self.email = userData["email"] as? String ?? ""
                }
            }
        }
    
    func fetchTrashCards() {
        databaseRef.observe(.value) { snapshot in
            var fetchedCards: [Model] = []
            for case let child as DataSnapshot in snapshot.children {
                if let value = child.value as? [String: Any] {
                    let card = Model(data: value)
                    fetchedCards.append(card)
                } else {
                    print("Could not cast child value to [String: Any]: \(child.value ?? "nil")")
                }
            }
            DispatchQueue.main.async {
                self.trashCards = fetchedCards
            }
        }
    }
    
    func addTrashCard(country: String, city: String, street: String, house: String, status: String, description: String, imageUrl: String) {
            let currentUserID = Auth.auth().currentUser?.uid ?? ""
            let newCard = Model(country: country, city: city, street: street, house: house, status: status, description: description, imageUrl: imageUrl, createdBy: self.name, creatorId: currentUserID)
            
            let newCardRef = databaseRef.child(newCard.id)
            newCardRef.setValue(newCard.toDictionary()) { error, _ in
                if let error = error {
                    print("Error adding card: \(error.localizedDescription)")
                } else {
                    print("Card added successfully")
                    self.fetchTrashCards()
                }
            }
        }
}



