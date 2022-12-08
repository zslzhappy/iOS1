//
//  File.swift
//  
//
//  Created by thor.wang on 2018/9/29.
//  Copyright © 2018年 . All rights reserved.
//

import Foundation
import UIKit

public extension  NSMutableAttributedString{
  
  
  @available(*, deprecated, message: "已废弃 使用addDeleteLineFixed")
  func addDeleteLine(color:UIColor? = nil){
    addAttributes([NSAttributedString.Key.strikethroughStyle: NSNumber(value: 1), NSAttributedString.Key.baselineOffset: NSNumber(value: 0)],
                                    range: NSMakeRange(0, self.length))
    if let c = color{
      addAttribute(NSAttributedString.Key.strikethroughColor, value: c, range: NSMakeRange(0, self.length))
    }
  }
  
  func addDeleteLineFixed(specialString:String? = nil,color:UIColor? = nil){
    var ranges = [NSMakeRange(0, self.length)]
    if let str = specialString{
      ranges = string.ranges(of: str)
    }
    ranges.forEach { r in
      addAttributes([NSAttributedString.Key.strikethroughStyle: NSNumber(value: 1)],range: r)
      if let c = color{
        addAttribute(NSAttributedString.Key.strikethroughColor, value: c, range: r)
      }
    }
  }
  
  func addBottomLine(specialString:String? = nil,color:UIColor? = nil){
    var ranges = [NSMakeRange(0, self.length)]
    if let str = specialString{
      ranges = string.ranges(of: str)
    }
    ranges.forEach { r in
      addAttributes([NSAttributedString.Key.underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)],
                                      range: r)
      if let c = color{
        addAttribute(NSAttributedString.Key.underlineColor, value: c, range: r)
      }
    }
  }
  
  static func bottomLineAttributes(color:UIColor? = nil) -> [NSAttributedString.Key:NSObject]{
    var dic = [NSAttributedString.Key:NSObject]()
    dic[.underlineStyle] = NSNumber(value: NSUnderlineStyle.single.rawValue)
    if let c = color{
      dic[.underlineColor] = c
    }
    return dic
  }
}

extension String{
  
  // 😒 swift中长度为1 oc为2 emoji表情长度不一样
  func ranges(of string: String) -> [NSRange] {
    var selfStr = self as NSString
    var allRange = [NSRange]()
    var length = 0
    while selfStr.range(of: string).location != NSNotFound {
      let range = selfStr.range(of: string)
      selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: "") as NSString
      allRange.append(NSMakeRange(range.location + length, range.length))
      length += range.length
    }
    return allRange
  }
  
}
