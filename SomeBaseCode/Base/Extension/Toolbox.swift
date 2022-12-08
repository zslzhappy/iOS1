//
//  File.swift
//  SomeBaseCode
//
//  Created by wl on 2022/12/8.
//

import Foundation

class Toolbox{
  public class func swizzleMethod(targetClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    guard let originalMethod = class_getInstanceMethod(targetClass, originalSelector),
          let swizzledMethod = class_getInstanceMethod(targetClass, swizzledSelector) else {
      return
    }
    
    let didAddMethod = class_addMethod(targetClass,
                                       originalSelector,
                                       method_getImplementation(swizzledMethod),
                                       method_getTypeEncoding(swizzledMethod))
    
    if didAddMethod {
      class_replaceMethod(targetClass,
                          swizzledSelector,
                          method_getImplementation(originalMethod),
                          method_getTypeEncoding(originalMethod))
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }
}
