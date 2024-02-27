//
//  File.swift
//  
//
//  Created by thor.wang on 2018/8/30.
//  Copyright © 2018年 . All rights reserved.
//

import Foundation
import UIKit
//MARK: Bundle的扩展

public extension Bundle{
  func loadViewFromNib<T:UIView>(nibName:String,owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil)  -> T?{
    
    if let arr = self.loadNibNamed(nibName, owner: owner, options: options){
      for v in arr {
        if v is T{
          return (v as! T)
        }
      }
    }
    return nil
  }
  
  class func locatedBundle(for aClass:AnyClass) ->Bundle{
    return Bundle.init(for: aClass)
  }
}


