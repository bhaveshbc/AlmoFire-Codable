//
//  NewsFeed.swift

//


import Foundation



class NewsFeed : Codable {
    
    let photoDetails : PhotoDetail?
    let photos : Photo?
    let scorer : Scorer?
    
    enum CodingKeys: String, CodingKey {
        case photoDetails = "PhotoDetails"
        case photos = "photos"
        case scorer = "scorer"
    }
   
  required  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photoDetails =  try values.decodeIfPresent(PhotoDetail.self, forKey: .photoDetails)
        photos =  try values.decodeIfPresent(Photo.self, forKey: .photos)
        scorer =  try values.decodeIfPresent(Scorer.self, forKey: .scorer)
    }
    
}


class UserNewsFeed : Codable {
    
    let photoDetails : PhotoDetail?
    let photos : Photo?
    let scorer : Scorer?
    
    enum CodingKeys: String, CodingKey {
        case photoDetails = "PhotoDetails"
        case photos = "photos"
        case scorer = "scorer"
    }
    
    required  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photoDetails =  try values.decodeIfPresent(PhotoDetail.self, forKey: .photoDetails)
        photos =  try values.decodeIfPresent(Photo.self, forKey: .photos)
        scorer =  try values.decodeIfPresent(Scorer.self, forKey: .scorer)
    }
    
}



struct userScoreList : Codable {
    
    let score : Score?
    let scorer : Scorer?
    
    enum CodingKeys: String, CodingKey {
        case score = "Score"
        case scorer = "scorer"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        score = try values.decodeIfPresent(Score.self, forKey: .score)
        scorer = try values.decodeIfPresent(Scorer.self, forKey: .scorer)
    }
}


struct Score : Codable {
    
    let createdDate : String?
    let score : Int?
    let scoreid : String?
    let updateDate : String?
    let ScreenShotTaken : Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case createdDate = "CreatedDate"
        case score = "score"
        case scoreid = "Scoreid"
        case updateDate = "UpdateDate"
        case ScreenShotTaken = "ScreenShotTaken"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        scoreid = try values.decodeIfPresent(String.self, forKey: .scoreid)
        updateDate = try values.decodeIfPresent(String.self, forKey: .updateDate)
        ScreenShotTaken = try values.decodeIfPresent(Bool.self, forKey: .ScreenShotTaken)
    }
    
}



class Scorer : Codable {
    
    let profilePicture : String?
    let scorerId : String?
    let username : String?
    let Username : String?
    let bio : String?
    let dOB : String?
    let email : String?
    let phoneNumber : String?
    
    
    enum CodingKeys: String, CodingKey {
        case profilePicture = "ProfilePicture"
        case scorerId = "ScorerId"
        case username = "username"
        case Username = "UserName"
        
        case bio = "bio"
        case dOB = "dOB"
        case email = "email"
        case phoneNumber = "phoneNumber"
        
    }
    
  required  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profilePicture = try values.decodeIfPresent(String.self, forKey: .profilePicture)
        scorerId = try values.decodeIfPresent(String.self, forKey: .scorerId)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        Username = try values.decodeIfPresent(String.self, forKey: .Username)
    
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        dOB = try values.decodeIfPresent(String.self, forKey: .dOB)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }
    
}


class Photo : Codable {
    
    let amount : Int?
    let commentONOFF : Bool?
    let compressedImgURL : String?
    let createdDate : String?
    let descriptionField : String?
    let hashtags : String?
    let imageUrl : String?
    let ImageName : String?
    let lan : Float?
    let lat : Float?
    let location : String?
    let photoid : String?
    let privacy : Bool?
    var score : Int?
    let screenshotONOFF : Bool?
    let sellONOFF : Bool?
    let sold : Bool?
    let totalComments : Int?
    var totalScore : Int?
    var TotalScreenshots : Int?
    var descriptionState : Int?
    
    enum CodingKeys: String, CodingKey {
        case amount = "Amount"
        case commentONOFF = "CommentONOFF"
        case compressedImgURL = "CompressedImgURL"
        case createdDate = "CreatedDate"
        case descriptionField = "Description"
        case hashtags = "Hashtags"
        case imageUrl = "imageUrl"
        case lan = "Lan"
        case lat = "Lat"
        case location = "Location"
        case photoid = "photoid"
        case privacy = "Privacy"
        case score = "Score"
        case screenshotONOFF = "ScreenshotONOFF"
        case sellONOFF = "SellONOFF"
        case sold = "Sold"
        case totalComments = "TotalComments"
        case totalScore = "TotalScore"
        case TotalScreenshots = "TotalScreenshots"
        case ImageName = "ImageName"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        commentONOFF = try values.decodeIfPresent(Bool.self, forKey: .commentONOFF)
        compressedImgURL = try values.decodeIfPresent(String.self, forKey: .compressedImgURL)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        hashtags = try values.decodeIfPresent(String.self, forKey: .hashtags)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        lan = try values.decodeIfPresent(Float.self, forKey: .lan)
        lat = try values.decodeIfPresent(Float.self, forKey: .lat)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        photoid = try values.decodeIfPresent(String.self, forKey: .photoid)
        privacy = try values.decodeIfPresent(Bool.self, forKey: .privacy)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        screenshotONOFF = try values.decodeIfPresent(Bool.self, forKey: .screenshotONOFF)
        sellONOFF = try values.decodeIfPresent(Bool.self, forKey: .sellONOFF)
        sold = try values.decodeIfPresent(Bool.self, forKey: .sold)
        totalComments = try values.decodeIfPresent(Int.self, forKey: .totalComments)
        totalScore = try values.decodeIfPresent(Int.self, forKey: .totalScore)
        TotalScreenshots = try values.decodeIfPresent(Int.self, forKey: .TotalScreenshots)
        ImageName = try values.decodeIfPresent(String.self, forKey: .ImageName)
        descriptionState = 0
    }
    
}
//"width": 16374,
//"Height": 3628,

class PhotoDetail : Codable {
    
    let createdDate : String?
    let device : String?
    let dimensions : String?
    let focalLength : String?
    let iSO : String?
    let photoDetailID : String?
    let shutterSpeed : String?
    let zoom : String?
    let width : Int?
    let Height : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case createdDate = "CreatedDate"
        case device = "Device"
        case dimensions = "Dimensions"
        case focalLength = "FocalLength"
        case iSO = "ISO"
        case photoDetailID = "PhotoDetailID"
        case shutterSpeed = "ShutterSpeed"
        case zoom = "Zoom"
        case width = "width"
        case Height = "Height"
    }
    
  required  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        device = try values.decodeIfPresent(String.self, forKey: .device)
        dimensions = try values.decodeIfPresent(String.self, forKey: .dimensions)
        focalLength = try values.decodeIfPresent(String.self, forKey: .focalLength)
        iSO = try values.decodeIfPresent(String.self, forKey: .iSO)
        photoDetailID = try values.decodeIfPresent(String.self, forKey: .photoDetailID)
        shutterSpeed = try values.decodeIfPresent(String.self, forKey: .shutterSpeed)
        zoom = try values.decodeIfPresent(String.self, forKey: .zoom)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        Height = try values.decodeIfPresent(Int.self, forKey: .Height)
    }
    
}
