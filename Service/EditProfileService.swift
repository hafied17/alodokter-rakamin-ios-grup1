//
//  EditProfileService.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 18/12/21.
//

import Foundation

class EditProfileService: BaseService {
    
    let userDefaults = UserDefaults()
    var email = ""
    var birthData = ""
    var phoneNumber = ""
    var fullName = ""
    var parameterp: [String:String] = [:]
    
    typealias ResponseType = User
    
    func method() -> Network.Method {
        return .patch
    }
    
    func setUrl() -> URL {
        let url: String = "https://medikuy.herokuapp.com/user/update/\(userDefaults.value(forKey: "id") ?? "")"
        return URL(string: url)!
    }
    
    func query() -> Network.QueryType {
        .json
    }
    
    func signature() -> Network.SignatureType {
        .emptySignature
    }
    
    func setParameters() -> [String : Any]? {
//        ["user_id":"1"]
        parameterp
    }
    
    func setHeaders() -> [String : String] {
        let headers: [String : String] = [
            "Authorization": "Bearer \(userDefaults.value(forKey: "token") ?? "")",
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func cachePolicy() -> NSURLRequest.CachePolicy {
        return .reloadRevalidatingCacheData
    }
    
    
}
