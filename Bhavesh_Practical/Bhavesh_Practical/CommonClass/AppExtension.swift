//
//  AppExtension.swift

//
//  Created by Bhavesh Chaudhari on 04/10/18.

//

import Foundation
import UIKit
import Accelerate


extension UIColor {
    class  func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


extension DateFormatter {
    var AppDateFomater : String {
        get {
            return "yyyy-MM-dd'T'HH:mm:ss.SSS"
        }
    }
}


extension UITextField {
    func insertView( toTextField insetView:UIView ,direction:TextFieldSubvuewDirection,mode:ViewMode) {
        if direction == .right {
            self.rightView = insetView
            self.rightViewMode = .whileEditing
        }
        else {
            self.leftView = insetView
            self.leftViewMode = .whileEditing
        }
    }
}

extension UIApplication {
    func gettopMostViewController() -> UIViewController? {
        return        self.keyWindow?.rootViewController?.findtopViewController()
    }
    
    
    var userInfo : UserInfo? {
        get {
            if let userinfo = (UIApplication.shared.delegate as! AppDelegate).UserInfo {
                return userinfo
            }
            return nil
        }
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func UTCToLocal() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatter.AppDateFomater
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let dt = dateFormatter.date(from: self) {
                return dt
        }
        return nil
    }
}




extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func findtopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return findtopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return findtopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return findtopViewController(controller: presented)
        }
        return controller
    }
    
    func addChiledController(Controller : UIViewController) {
        self.addChild(Controller)
        self.view.addSubview(Controller.view)
        Controller.didMove(toParent: self)
    }
    
    func presentAlerterror(title:String,message:String, okclick:(()->())?) {
        let AlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if okclick != nil {
                okclick!()
            }
        }
        AlertController.addAction(okAction)
        self.present(AlertController, animated: true) {
            
        }
    }
    
    func photoUploadingActionSheet(isRemove:Bool,compltion:@escaping (photoUploadingOption)->()){
        let phtoUploadingController: UIAlertController = UIAlertController(title: "Upload Profile Picture", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        
        let TakePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { _ in
            compltion(.takePhoto)
        }
        
        
        
        let ChoosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default) { _ in
            compltion(.chosePhoto)
        }
        
        let RemovePhotoAction = UIAlertAction(title: "Remove Photo", style: .default) { _ in
            compltion(.removePhoto)
        }
        
        
        phtoUploadingController.addAction(TakePhotoAction)
        phtoUploadingController.addAction(ChoosePhotoAction)
        if isRemove {
            phtoUploadingController.addAction(RemovePhotoAction)
        }
        phtoUploadingController.addAction(cancelActionButton)
        self.present(phtoUploadingController, animated: true, completion: nil)
        
    }
}







extension UIWindow {
    public func swapRootViewControllerWithAnimation(newViewController:UIViewController, animationType:SwapRootVCAnimationType, completion: (() -> ())? = nil)
    {
        guard let currentViewController = rootViewController else {
            return
        }
        
        let width = currentViewController.view.frame.size.width;
        let height = currentViewController.view.frame.size.height;
        
        var newVCStartAnimationFrame: CGRect?
        var currentVCEndAnimationFrame:CGRect?
        
        var newVCAnimated = true
        
        switch animationType
        {
        case .push:
            newVCStartAnimationFrame = CGRect(x: width, y: 0, width: width, height: height)
            currentVCEndAnimationFrame = CGRect(x: 0 - width/4, y: 0, width: width, height: height)
        case .pop:
            currentVCEndAnimationFrame = CGRect(x: width, y: 0, width: width, height: height)
            newVCStartAnimationFrame = CGRect(x: 0 - width/4, y: 0, width: width, height: height)
            newVCAnimated = false
        case .present:
            newVCStartAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
        case .dismiss:
            currentVCEndAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
            newVCAnimated = false
        }
        
        newViewController.view.frame = newVCStartAnimationFrame ?? CGRect(x: 0, y: 0, width: width, height: height)
        
        addSubview(newViewController.view)
        
        if !newVCAnimated {
            bringSubviewToFront(currentViewController.view)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            if let currentVCEndAnimationFrame = currentVCEndAnimationFrame {
                currentViewController.view.frame = currentVCEndAnimationFrame
            }
            
            newViewController.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }, completion: { finish in
            self.rootViewController = newViewController
            completion?()
            
        })
        self.makeKeyAndVisible()
        
    }
}






extension UIImageView {
    public func maskCircle() {
        self.contentMode = UIView.ContentMode.scaleAspectFit
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}



extension UIView {
    func addGradiuntColor() {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradient.colors = [UIColor.hexStringToUIColor(hex: "00A0BF").cgColor,
                           UIColor.hexStringToUIColor(hex: "00A0BF").cgColor,
                           UIColor.hexStringToUIColor(hex: "C2B33E").cgColor,
                           UIColor.hexStringToUIColor(hex: "FFB915").cgColor]
        
        gradient.locations = [0.073,0.10,0.69,0.87]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradient.contentsScale = UIScreen.main.scale
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 2, dy: 2), cornerRadius: 21).cgPath
        
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
    
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 1.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    
    func ApplyGradiantText(colors:[CGColor],text:String,Font:UIFont) {
        let gradient = CAGradientLayer()
        
        // gradient colors in order which they will visually appear
        gradient.colors = [UIColor.hexStringToUIColor(hex: "00A0BF").cgColor,
                           UIColor.hexStringToUIColor(hex: "00DFBF").cgColor,
            
            UIColor.hexStringToUIColor(hex: "C2B33E").cgColor,
            UIColor.hexStringToUIColor(hex: "FFCC15").cgColor]
        
        
         gradient.locations = [0.07,0.45,0.65,0.95]
        gradient.contentsScale = UIScreen.main.scale
        
        // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
//        gradient.locations = [0,10.34,69.08,87.68]
        
        // set the gradient layer to the same size as the view
        gradient.frame = self.bounds
        // add the gradient layer to the views layer for rendering
        self.layer.addSublayer(gradient)
        
        
        // PART 2
        
        // Create a label and add it as a subview
        let label = UILabel(frame: self.bounds)
        label.text = "LOG IN"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        self.addSubview(label)
        
        // Tha magic! Set the label as the views mask
        self.mask = label
    }
    
    func setBottomBorder() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.7)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}






extension StringProtocol {
    var ascii: [UInt32] {
        return unicodeScalars.compactMap { $0.isASCII ? $0.value : nil }
    }
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}




extension UIImage {
    func imageCropped(toRect rect: CGRect) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        let imageRef = cgImage.cropping(to: rect)
        let cropped = UIImage(cgImage: imageRef!)
        return cropped
    }
    
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
 
        func resizeVI(size:CGSize) -> UIImage? {
            let cgImage = self.cgImage!
            
            var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil,
                                              bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
                                              version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
            
            
            
            var sourceBuffer = vImage_Buffer()
            defer {
                sourceBuffer.data.deallocate()
            }
            
            var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
            guard error == kvImageNoError else { return nil }
            
            // create a destination buffer
            let scale = self.scale
            let destWidth = Int(size.width)
            let destHeight = Int(size.height)
            let bytesPerPixel = self.cgImage!.bitsPerPixel / 8
            let destBytesPerRow = destWidth * bytesPerPixel
            let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
            defer {
                destData.deallocate()
            }
            var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
            
            // scale the image
            error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
            guard error == kvImageNoError else { return nil }
            
            // create a CGImage from vImage_Buffer
            let destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
            guard error == kvImageNoError else { return nil }
            
            // create a UIImage
            let resizedImage = destCGImage.flatMap { UIImage(cgImage: $0, scale: 0.0, orientation: self.imageOrientation) }
            return resizedImage
        }
    
    
    func resizedTo(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    func rotateUp() -> UIImage {
        guard imageOrientation != .up else { return self }
        
        var transform:CGAffineTransform = .identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
        case .upMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            transform = .identity
        }
        
        
        //Apply the transfrom to a graphics context and redraw the image
        UIGraphicsBeginImageContext(size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        context.concatenate(transform)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? self
    }
    
    func fixedOrientation() -> UIImage {
        if imageOrientation == .up { return self }
        
        var transform:CGAffineTransform = .identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height).rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0).rotated(by: .pi/2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height).rotated(by: -.pi/2)
        default: break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0).scaledBy(x: -1, y: 1)
        default: break
        }
        
        let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height),
                            bitsPerComponent: cgImage!.bitsPerComponent, bytesPerRow: 0,
                            space: cgImage!.colorSpace!, bitmapInfo: cgImage!.bitmapInfo.rawValue)!
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.height,height: size.width))
        default:
            ctx.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.width,height: size.height))
        }
        return UIImage(cgImage: ctx.makeImage()!)
    }
    
    var scaledToSafeUploadSize: UIImage? {
        let maxImageSideLength: CGFloat = 480
        
        let largerSide: CGFloat = max(size.width, size.height)
        let ratioScale: CGFloat = largerSide > maxImageSideLength ? largerSide / maxImageSideLength : 1
        let newImageSize = CGSize(width: size.width / ratioScale, height: size.height / ratioScale)
        
        return image(scaledTo: newImageSize)
    }
    
    func image(scaledTo size: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


extension NSLayoutConstraint {
    
    @IBInspectable var preciseConstant: CGFloat {
        get {
            return constant * UIScreen.main.scale
        }
        set {
            
            constant =  (newValue * UIScreen.main.bounds.size.height)  / 736
            //print(constant)
        }
    }
    
    
    @IBInspectable var preciseWidthConstant: CGFloat {
        get {
            return constant * UIScreen.main.scale
        }
        set {
            
            constant =  (newValue * UIScreen.main.bounds.size.width)  / 414
            
        }
    }
    
    
}




extension Date {
    func timeAgo(numericDates: Bool = false) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = self < now ? self : now
        let latest =  self > now ? self : now
        
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfMonth, .month, .year, .second]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        
        let year = components.year ?? 0
        let month = components.month ?? 0
        let weekOfMonth = components.weekOfMonth ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        
        switch (year, month, weekOfMonth, day, hour, minute, second) {
        case (let year, _, _, _, _, _, _) where year >= 2: return "\(year) years ago"
        case (let year, _, _, _, _, _, _) where year == 1 && numericDates: return "1 year ago"
        case (let year, _, _, _, _, _, _) where year == 1 && !numericDates: return "Last year"
        case (_, let month, _, _, _, _, _) where month >= 2: return "\(month) months ago"
        case (_, let month, _, _, _, _, _) where month == 1 && numericDates: return "1 month ago"
        case (_, let month, _, _, _, _, _) where month == 1 && !numericDates: return "Last month"
        case (_, _, let weekOfMonth, _, _, _, _) where weekOfMonth >= 2: return "\(weekOfMonth) weeks ago"
        case (_, _, let weekOfMonth, _, _, _, _) where weekOfMonth == 1 && numericDates: return "1 week ago"
        case (_, _, let weekOfMonth, _, _, _, _) where weekOfMonth == 1 && !numericDates: return "Last week"
        case (_, _, _, let day, _, _, _) where day >= 2: return "\(day) days ago"
        case (_, _, _, let day, _, _, _) where day == 1 && numericDates: return "1 day ago"
        case (_, _, _, let day, _, _, _) where day == 1 && !numericDates: return "Yesterday"
        case (_, _, _, _, let hour, _, _) where hour >= 2: return "\(hour) hours ago"
        case (_, _, _, _, let hour, _, _) where hour == 1 && numericDates: return "1 hour ago"
        case (_, _, _, _, let hour, _, _) where hour == 1 && !numericDates: return "An hour ago"
        case (_, _, _, _, _, let minute, _) where minute >= 2: return "\(minute) minutes ago"
        case (_, _, _, _, _, let minute, _) where minute == 1 && numericDates: return "1 minute ago"
        case (_, _, _, _, _, let minute, _) where minute == 1 && !numericDates: return "A minute ago"
        case (_, _, _, _, _, _, let second) where second >= 10: return "\(second) seconds ago"
        default: return "Just now"
        }
    }
}










