//
//  UserDefaults.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 08.05.2022.
//

import Foundation

protocol UserDataFunctions {
    func saveData(user: User?) -> Void
    func getUserId() -> String
    func getUserName() -> String
    func getName() -> String
    func getLastName() -> String
    func getUserChats() -> [String]
    func getUserFriends() -> [String]
}

final class UserData {
    static var shared = UserData()
}

extension UserData: UserDataFunctions {
    func getUserId() -> String {
        return UserDefaults.standard.string(forKey: "User_id") ?? "Unknown id"
    }
    
    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: "Username") ?? "Unknown username"
    }
    
    func getName() -> String {
        return UserDefaults.standard.string(forKey: "FirstName") ?? "Unknown first name"
    }
    
    func getLastName() -> String {
        return UserDefaults.standard.string(forKey: "LastName") ?? "Unknown last name"
    }
    
    func getUserChats() -> [String] {
        return UserDefaults.standard.value(forKey: "UserChats") as! [String]
    }

    
    func getUserFriends() -> [String] {
        return UserDefaults.standard.value(forKey: "UserFriends") as! [String]
    }
    
    func saveData(user: User?) {
        UserDefaults.standard.set(user?.id, forKey: "User_id")
        UserDefaults.standard.set(user?.username, forKey: "Username")
        UserDefaults.standard.set(user?.firstName, forKey: "FirstName")
        UserDefaults.standard.set(user?.lastName, forKey: "LastName")
        UserDefaults.standard.set(user?.userChats, forKey: "UserChats")
        UserDefaults.standard.set(user?.userFriends, forKey: "UserFriends")
    }
    
}
