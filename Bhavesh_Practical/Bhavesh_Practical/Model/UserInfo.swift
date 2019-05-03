//
//  UserInfo.swift

//


//

import Foundation
import UIKit

struct UserInfo : Codable {
    var access_token : String?
    var token_type : String?
    var expires_in : Int?
    var userName : String?
    var issued : String?
    var expires : String?
    var scorerId : String?
    var ScorerId : String?
    var password : String?
    var userImage : UIImage? = nil
    
    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case token_type = "token_type"
        case expires_in = "expires_in"
        case userName = "userName"
        case issued = "issued"
        case expires = "expires"
        case scorerId = "scorerId"
        case ScorerId = "ScorerId"
        case password = "password"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
        token_type = try values.decodeIfPresent(String.self, forKey: .token_type)
        expires_in = try values.decodeIfPresent(Int.self, forKey: .expires_in)
        issued = try values.decodeIfPresent(String.self, forKey: .issued)
        expires = try values.decodeIfPresent(String.self, forKey: .expires)
        scorerId = try values.decodeIfPresent(String.self, forKey: .scorerId)
        ScorerId = try values.decodeIfPresent(String.self, forKey: .ScorerId)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
    }
    //
}



struct UserDetails : Codable {
    
    let scorer : Scorer?
    let scorerSW : ScorerSW?
    
    enum CodingKeys: String, CodingKey {
        case scorer = "Scorer"
        case scorerSW = "ScorerBusiness"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        scorer =    try values.decodeIfPresent(Scorer.self, forKey: .scorer)
        scorerSW =  try values.decodeIfPresent(ScorerSW.self, forKey: .scorerSW)
    }
    
}


struct ScorerSW : Codable {
    
    let educationCategory : String?
    let educationCollege : String?
    let educationType : String?
    let gender : Int?
    let status : String?
    let statusVisible : String?
    let workCompany : String?
    let workTitle : String?
    
    enum CodingKeys: String, CodingKey {
        case educationCategory = "EducationCategory"
        case educationCollege = "EducationCollege"
        case educationType = "EducationType"
        case gender = "Gender"
        case status = "status"
        case statusVisible = "StatusVisible"
        case workCompany = "WorkCompany"
        case workTitle = "WorkTitle"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        educationCategory = try values.decodeIfPresent(String.self, forKey: .educationCategory)
        educationCollege = try values.decodeIfPresent(String.self, forKey: .educationCollege)
        educationType = try values.decodeIfPresent(String.self, forKey: .educationType)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        statusVisible = try values.decodeIfPresent(String.self, forKey: .statusVisible)
        workCompany = try values.decodeIfPresent(String.self, forKey: .workCompany)
        workTitle = try values.decodeIfPresent(String.self, forKey: .workTitle)
    }
    
}

