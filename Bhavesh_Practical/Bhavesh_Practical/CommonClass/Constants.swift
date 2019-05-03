//
// 
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 22/09/18.
//  Copyright © 2018 Bhavesh Chaudhari. All rights reserved.
//

import Foundation
import UIKit

struct K {
    struct ProductionServer {
        static let baseURL = "http://api.scorebored.in/api/"
        static let ApiKey = "dcb73f51d03e45898717a2d8c692fa2b"
    }
    
    struct ItunesURl{
        static let baseURL = "your - itunes - url"
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/x-www-form-urlencoded"
}


struct PlaceHolder {
      var postPlaceHolder : UIImage {
        get {
            return UIImage(contentsOfFile: Bundle.main.path(forResource: "placeHolder", ofType: "png") ?? "")!
        }
    }
    
      var ProfilePlaceHolder : UIImage {
        get {
            return UIImage(contentsOfFile: Bundle.main.path(forResource: "man", ofType: "png") ?? " ")!
        }
    }
}
