//
//  AppEnum.swift

//
//  Created by Bhavesh Chaudhari on 04/10/18.

//

import Foundation
import UIKit


enum ProfilePickerType {
    case socialwormer
    case businessprofesion
    case busonesssubtype
    case photocategory
//    case photocategory
}

enum TextFieldSubvuewDirection {
    case right
    case left
}

enum TextFieldMode {
    case alwayes
    case whileediting
}


enum userprofileType {
    case business
    case social
}

public enum SwapRootVCAnimationType {
    case push
    case pop
    case present
    case dismiss
}


enum NewsFeedType {
    case own
    case other
}

enum NewsFeedViewType {
    case fromdashBored
    case fromProfile
}


enum photoUploadingOption {
    case takePhoto
    case chosePhoto
    case removePhoto
}


enum camraOpenFor {
    case userprofilepic
    case usermedia
}


enum imagePreviewState {
    case fromCamera(image:UIImage)
    case fromNewsFeed(imageUrl:NewsFeed)
}

enum signUpApiClient {
    case socialWarmer
    case business
    case businessSubtype
}


enum commentActionSheetAction {
    case delete
    case edit
}

enum SearchCellViewState {
    case fromSearchController
    case hideFromController
}

enum AppStoryboard : String {
    
    case Main,NewsFeeds,Profile,Upload,Search
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
