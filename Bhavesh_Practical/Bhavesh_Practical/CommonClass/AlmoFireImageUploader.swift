//
//  AlmoFireImageUploader.swift

//


//

import Foundation
import Alamofire


enum UploadingCase {
    case sucess
    case error(error : Error)
}



class ImageUploder {
    
   class  func uploadImage(baseUrl:String,parametr:[String:Any],Header:[String:String],imageArray:[String:UIImage],compltion:@escaping (UploadingCase)->())
    {
       
        
//        test(paramter:parametr,Header:Header,image:UIImage(named:"100.png")!)
        (UIApplication.shared.delegate as! AppDelegate).addProgressView()
        var headers = Header
        var length : Int = 0
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 99999999
        manager.upload(multipartFormData: { multipartFormData in

            for image in imageArray {
                let imageName = image.key
                guard let imageData = image.value.jpegData(compressionQuality: 1) else {
                    return
                }
                 multipartFormData.append(imageData, withName: "\(imageName)[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                length += imageData.count
            }

            for (key, value) in parametr {
                guard let encodedData = "\(value)".data(using: .utf8) else {
                    print("DataNotEncoded")
                    break
                }

                multipartFormData.append(encodedData, withName: key)

               length += encodedData.count
            }

            headers["Content-Length"] = "\(length)"

//            print("Content-Length \(headers["Content-Length"])")


        }, to: baseUrl,method:.post,headers:headers,

           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.value!)
                    (UIApplication.shared.delegate as! AppDelegate).hideProgrssVoew()
                    compltion(.sucess)
                }

                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
            case .failure(let error):
                print(error)
                (UIApplication.shared.delegate as! AppDelegate).hideProgrssVoew()
                compltion(.error(error: error))
            }
        })
 
    }
}
