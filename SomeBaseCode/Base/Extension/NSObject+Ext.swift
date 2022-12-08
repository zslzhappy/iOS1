//
//  NSObject+Ext.swift
//  Copyright © 2018 . All rights reserved.
//

import RxSwift


public extension NSObject {
  
  static var disBagKey = "disBagKey"
  var disposedBag:DisposeBag {
    get {
      let bag:DisposeBag? = getAssociated(associatedKey: &NSObject.disBagKey)
      if bag.isSome{
        return bag!
      }
      let b = DisposeBag()
      setAssociated(value: b, associatedKey: &NSObject.disBagKey)
      return b
    }
  }
  func clearDisposedBag(){
    objc_setAssociatedObject(self, &NSObject.disBagKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  class var className: String{
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
}

public extension NSObject {
  
  func setAssociated<T>(value: T, associatedKey: UnsafeRawPointer, policy: objc_AssociationPolicy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) -> Void {
    objc_setAssociatedObject(self, associatedKey, value, policy)
  }
  
  func getAssociated<T>(associatedKey: UnsafeRawPointer) -> T? {
    let value = objc_getAssociatedObject(self, associatedKey) as? T
    return value;
  }
  
}
