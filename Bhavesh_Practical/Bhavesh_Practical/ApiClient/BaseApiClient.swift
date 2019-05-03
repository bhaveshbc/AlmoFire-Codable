//
//  BaseApiClient.swift

//
//  Created by Bhavesh Chaudhari on 11/10/18.

//

import Foundation
import Alamofire

class BaseApiClient {
    
    static let `default`  = BaseApiClient()
    
    private init() {
        
    }
    
    func fetch<model:Codable>(request:APIRouter,decoder : JSONDecoder = JSONDecoder()  ,onSuccess: @escaping (model?) -> Void) {
        
        print("Request URL ========> \(request.fullURL)")
        print("Request PARAMTER ========> \(String(describing: request.parameters))")
        print("Request Header ========> \(request.headers)")
        if Connectivity.isReachable {
            (UIApplication.shared.delegate as! AppDelegate).addProgressView()
            Alamofire.request(request).responseJSON { (response) in
    
                (UIApplication.shared.delegate as! AppDelegate).displayLoader = true
                
                switch response.result {
                case .success( let apiResponse) :
                    
                    print("Request Response ========> \(apiResponse)")
                    
                    DispatchQueue.main.async {
                        (UIApplication.shared.delegate as! AppDelegate).hideProgrssVoew()
                    }   
                    
                    if let responseData = apiResponse as? [String:Any] , let status  = responseData["Code"] as? String {
                        
                        if status == "SUCCESS" {
                            do {
                                let responseModel  = try decoder.decode(model.self, from: response.data!)
                                onSuccess(responseModel)
                            }
                            catch let error as NSError {
                               // onSuccess(nil)
                                print("failed reason : \(error.localizedDescription)")
                            }
                        }
                        else {
                            if let message = responseData["Message"] as? String {
//                                onSuccess(nil)
                                UIApplication.shared.gettopMostViewController()?.presentAlerterror(title: "Erorr", message: message ,okclick: nil)
                            }
                        }
                    }
                    else {
//                        onSuccess(nil)
                        UIApplication.shared.gettopMostViewController()?.presentAlerterror(title: "Erorr", message: "An error has occurred." ,okclick: nil)
                    }
                case .failure(let error) :
//                    onSuccess(nil)
                    DispatchQueue.main.async {
                        (UIApplication.shared.delegate as! AppDelegate).hideProgrssVoew()
                    }
                    UIApplication.shared.gettopMostViewController()?.presentAlerterror(title: "Erorr", message: error.localizedDescription, okclick: nil)
                }
            }
        }
        else {
//            onSuccess(nil)
            (UIApplication.shared.delegate as! AppDelegate).hideProgrssVoew()
            UIApplication.shared.gettopMostViewController()?.presentAlerterror(title: "Error", message: "connnection not avilabel", okclick: nil)
        }
    }
    
}


class Connectivity {
    class var isReachable:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}




struct ResponseBaseArray<T:Codable> : Codable {
    
    let code : String?
    let data : [T]?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case data = "Data"
        case message = "Message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([T].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct ResponseBaseObject<T:Codable> : Codable {
    
    let code : String?
    let data : T?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case data = "Data"
        case message = "Message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(T.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}














