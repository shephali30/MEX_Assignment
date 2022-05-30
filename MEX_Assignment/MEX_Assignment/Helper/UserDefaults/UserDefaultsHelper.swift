//
//  UserDefaultsHelper.swift
//  MEX_Assignment
//
//  Created by Shephali Srivas on 29/05/22.
//

import Foundation

class UserDefaultsHelper {
    //MARK: - shared instance
    static let shared: UserDefaultsHelper = {
       return UserDefaultsHelper()
    }()
    
    //MARK: - save data in Userdefaults
    func storeData(key: String, value: [Bot]) -> Bool {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            UserDefaults.standard.set(data, forKey: key)
            return true
        } catch {
            print("Unable to Encode Note (\(error))")
            return false
        }
    }
    
    //MARK: - fetch data from Userdefaults
    func fetchData(key: String) -> [Bot]? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let notes = try decoder.decode([Bot].self, from: data)
                return notes

            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return nil
    }
}

struct UserDefaultsKey {
    static let botKey = "Bot"
}
