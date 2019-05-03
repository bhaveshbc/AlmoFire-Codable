//
//  ImageLoader.swift

//


//


import UIKit
import Kingfisher




typealias ImageLoadOperationCompletionHandlerType = ((UIImage) -> ())?
class ImageLoadOperation: Operation {
    var url: String
    var completionHandler: ImageLoadOperationCompletionHandlerType?
    var image: UIImage?
    
    
    init(url: String) {
        self.url = url
    }
    
    override func main() {
        if isCancelled {
            return
        }
        let cached = ImageCache.default.imageCachedType(forKey: url)
        if cached != .none {
            getImageFromCache(key: url) { [weak self] (cachedImage) in
                self?.image = cachedImage
                if self?.completionHandler! != nil {
                    self?.completionHandler!!(cachedImage)
                }
            }
        }
        else {
            getImageFromServer(key: url) { [weak self] (cahcedImage) in
                self?.image = cahcedImage
                ImageCache.default.store(cahcedImage, forKey: self!.url)
                if self?.completionHandler! != nil {
                    self?.completionHandler!!(cahcedImage)
                }
            }
        }
    }
    
    func getImageFromCache(key:String,complition:@escaping (UIImage)->()) {
        ImageCache.default.retrieveImage(forKey: url, options: nil) { [weak self] (image, cachetype) in
            
            guard let cachedImage = image , let opCancelled = self?.isCancelled , opCancelled == false  else {
                return
            }
            complition(cachedImage)
        }
    }
    
    func getImageFromServer(key:String,complition:@escaping (UIImage)->()) {
        if let imageUrl = URL(string: key) {
            KingfisherManager.shared.retrieveImage(with: imageUrl, options: nil, progressBlock: nil) { [weak self] (image, error, cachetype, _ ) in
                if error == nil {
                    guard let cachedImage = image , let opCancelled = self?.isCancelled , opCancelled == false  else {
                        return
                    }
                    
                    
//                        let finalheight = (UIScreen.main.bounds.width * CGFloat(cachedImage.size.height)) / CGFloat(cachedImage.size.width)
//                        let newImage = cachedImage.resize(targetSize: CGSize(width: UIScreen.main.bounds.width, height: finalheight))
                        complition(cachedImage)
                    
                }
                else {
                    print("Error ###### == Errror While Downloading Image")
                }
            }
        }
        else {
            print("Error ###### == can't create Url of String")
        }
    }
}


enum cachedResult {
    case sucess(image : UIImage)
    case failure
    case error
}






