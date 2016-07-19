//
//  File.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 18/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import Foundation

extension DeviceListViewController {
    internal override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        // make sure this isn't a subclass
        if self !== DeviceListViewController.self {
            return
        }
        
        dispatch_once(&Static.token) {
            let originalSelector = #selector(DeviceListViewController.centralManagerDidUpdateState(_:))
            let swizzledSelector = #selector(DeviceListViewController.mockData)
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    // MARK: - Method Swizzling
    
    func mockData(){
        print("mock")
        
    }
    
    //<CBPeripheral: 0x1700ea100, identifier = F1BE15CB-9004-8BE4-0966-35D934B81C35, name = Charge, state = disconnected>
    
    
}