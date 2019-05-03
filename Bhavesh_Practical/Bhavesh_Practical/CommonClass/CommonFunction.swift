//
//  CommonFunction.swift

//
//  Created by Bhavesh Chaudhari on 08/10/18.

//

import Foundation
import UIKit


func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}


func isvalidPassword(paswordString:String) -> Bool {
    let emailRegEx = "^(?=.*[A-z])(?=.*[0-9]).{8,}$"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: paswordString)
}


typealias Debounce<T> = (_ : T) -> Void

func debounce<T>(interval: Int, queue: DispatchQueue, action: @escaping Debounce<T>) -> Debounce<T> {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(interval)
    
    return { param in
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay
        
        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()
            
            if now.rawValue >= when.rawValue {
                action(param)
            }
        }
    }
}


