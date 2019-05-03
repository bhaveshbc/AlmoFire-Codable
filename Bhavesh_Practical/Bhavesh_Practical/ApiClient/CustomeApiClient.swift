//
//  CustomeApiClient.swift
//  Networking
//
//  Created by Bhavesh Chaudhari on 26/09/18.
//  Copyright © 2018 Bhavesh Chaudhari. All rights reserved.
//

import Foundation
import Alamofire


class customeClient  {
    //MARK:- because All three SocialWarmer,business and businessSubType have Common Response
   
    
    static func userLogin(parameter:[String:Any],completion:@escaping (UserInfo)->Void) {
        BaseApiClient.default.fetch(request: APIRouter.login(usermodel: parameter)) { (response:ResponseBaseObject<UserInfo>?) in
            if let data = response?.data {
                completion(data)
            }
        }
    }
    
  
    
    static func getNewsFeed(parameter:[String:Any],completion:@escaping ([NewsFeed])->Void) {
        BaseApiClient.default.fetch(request: APIRouter.NwesFeed(usermodel:parameter )) { (response:ResponseBaseArray<NewsFeed>?) in
            if let data = response?.data {
                completion(data)
            }
        }
    }
}

 
    
    
