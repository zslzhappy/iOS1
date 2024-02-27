//
//  File.swift
//
//
//  Created by thor.wang on 2018/8/21.
//  Copyright © 2018年 . All rights reserved.
//

import Foundation
import UIKit
//MARK: 生成富文本的类
public class YAttributeTextFixed: NSObject {
  
  private var textColor :UIColor = UIColor.black
  private var textFont :UIFont = UIFont.systemFont(ofSize: 14)
  private var _paraGraphStyle:NSMutableParagraphStyle?
  private var attributeString:NSMutableAttributedString = NSMutableAttributedString(string: "")
  private var lineHeight:CGFloat?
  private var label:UILabel?
  public init(_ label:UILabel? = nil){
    self.label = label
  }
  public func textColor(color:UIColor) ->  Self {
    self.textColor =  color
    return self
  }
  
  public func textFont(font:UIFont) ->  Self {
    self.textFont =  font
    return self
  }
  
  public func text(text:String?) ->  Self{
    if let text = text{
      var attri = [NSAttributedString.Key.font : textFont,NSAttributedString.Key.foregroundColor : textColor] as [NSAttributedString.Key :Any]
      if let lineHeight = lineHeight{
        attri[NSAttributedString.Key.baselineOffset] = (lineHeight - textFont.lineHeight)/4
      }
      if _paraGraphStyle.isSome{
        attri[NSAttributedString.Key.paragraphStyle] = _paraGraphStyle!
      }
      let temp = NSAttributedString(string: text, attributes: attri)
      attributeString.append(temp)
    }
    return self
  }
  
  ///行间距
  public func lineSpace(_ space:CGFloat) ->  Self {
    if _paraGraphStyle.isNone{
      _paraGraphStyle = getAParaGraphStyle()
    }
    _paraGraphStyle?.lineSpacing = space
    return self
  }
  
  /// lineBreakeMode（可能只需为TTTAttributedLabel设置）
  public func lineBreakMode(_ mode:NSLineBreakMode) ->  Self {
    if _paraGraphStyle.isNone{
      _paraGraphStyle = getAParaGraphStyle()
    }
    _paraGraphStyle?.lineBreakMode = mode
    return self
  }
  
  ///AlignmentMode
  public func alignmentMode(_ mode:NSTextAlignment) ->  Self {
    if _paraGraphStyle.isNone{
      _paraGraphStyle = getAParaGraphStyle()
    }
    _paraGraphStyle?.alignment = mode
    return self
  }
  
  ///lineHeight
  public func lineHeight(_ height:CGFloat) ->  Self {
    lineHeight = height
    if _paraGraphStyle.isNone{
      _paraGraphStyle = getAParaGraphStyle()
    }
    _paraGraphStyle?.maximumLineHeight = height
    _paraGraphStyle?.minimumLineHeight = height
    return self
  }
  
  public func toAttributeString() ->  NSAttributedString{
    return attributeString
  }
  
  public var paraGraphStyle:NSParagraphStyle?{
    return _paraGraphStyle
  }
  
  private func getAParaGraphStyle()->NSMutableParagraphStyle{
    let p = NSMutableParagraphStyle()
    if let label = label {
      p.lineBreakMode = label.lineBreakMode
      if label.numberOfLines == 0{
        p.lineBreakMode = .default
      }
    }else{
      p.lineBreakMode = .byTruncatingTail
    }
    return p
  }
  
}

public extension NSLineBreakMode{
  /// byWordWrapping
  static let `default` = NSLineBreakMode.byWordWrapping
}

//MARK: YAttributeTextFixed示例 
private func test(){
  _ = YAttributeTextFixed()
    .textFont(font: UIFont.systemFont(ofSize: 14))
    .textColor(color: UIColor.red)
    .text(text: "123")
    .textColor(color: UIColor.green)
    .text(text: "456")
    .toAttributeString()
}
