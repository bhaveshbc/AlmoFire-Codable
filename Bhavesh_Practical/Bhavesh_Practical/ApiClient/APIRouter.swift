//
//  AutherWebViewController.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 26/09/18.
//  Copyright © 2018 Bhavesh Chaudhari. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {

    case GetCountries
    case login(usermodel:Parameters)
    case NwesFeed(usermodel:Parameters)
    
    

    // MARK: - HTTPMethod
     var method: HTTPMethod {
        switch self {
        case  .GetCountries:
            return .get
        case .login,.NwesFeed :
            return .post
        }
    }
    
    
    //MARK:- encoding
    
   var encoding: ParameterEncoding {
        return method == .post ? URLEncoding() : JSONEncoding.prettyPrinted
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login :
            return "account/login"
        case .NwesFeed :
            return "Activity/NewsFeed"
        case .GetCountries :
            return "Activity/GetCountries"
        }
    }
    
    var fullURL: String {
         return K.ProductionServer.baseURL + path
    }
    
    
    var headers: HTTPHeaders {
        return ["Content-Type" :ContentType.json.rawValue]
    }
    
    
    
    // MARK: - Parameters
     var parameters: Parameters? {
        switch self {
        case .GetCountries:
            return nil
        case .login(let model),.NwesFeed(let model)  :
            return model
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url:URL(string: K.ProductionServer.baseURL + path)! )
       
        
        
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        var token = ""
        if let userinfo = (UIApplication.shared.delegate as! AppDelegate).UserInfo {
            if let usertoken =  userinfo.access_token {
                    token = usertoken
            }
        }
        
        print("user token ======== \(token)")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
        
        if let parameters = parameters {
            do {
                let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
                return encodedURLRequest
            } catch  {
               
            }
        }
         return urlRequest
    }
}







