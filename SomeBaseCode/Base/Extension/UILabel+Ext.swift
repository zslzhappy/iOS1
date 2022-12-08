//
//  File.swift
//  
//
//  Created by thor.wang on 2018/11/1.
//  Copyright © 2018年 . All rights reserved.
//

import Foundation
import UIKit
public extension UILabel{
  
  @discardableResult
  func setTextFont(font:UIFont) -> Self{
    self.font = font
    return self
  }
  
  @discardableResult
  func setTextColor(color:UIColor) -> Self{
    self.textColor = color
    return self;
  }
  
  /*
   @discardableResult
   public func setAlign(_ alignment:NSTextAlignment) -> Self{
   self.textAlignment = alignment
   return self;
   }
   */
  
  @discardableResult
  func setLightTextColor(color:UIColor) -> Self{
    self.highlightedTextColor = color;
    return self;
  }
  
  @discardableResult
  func setNumberLines(num:Int) -> Self{
    self.numberOfLines = num
    return self
  }
  
  @discardableResult
  func setText(_ text:String?) -> Self{
    self.text = text
    return self
  }
  
  @discardableResult
  func setLineBreakMode(_ model:NSLineBreakMode) -> Self{
    self.lineBreakMode = model
    return self
  }
  
  @discardableResult
  func setAlignment(_ alignment:NSTextAlignment) -> Self{
    self.textAlignment = alignment
    return self
  }
}

extension UILabel{
  /// 某一range的字符在label中的frame
  public func boundingRectForCharacter(at range:NSRange) ->CGRect{
    guard let attributedText = attributedText else{ return CGRect.zero }
    let textStorage = NSTextStorage(attributedString: attributedText)
    let layoutManager = NSLayoutManager()
    textStorage.addLayoutManager(layoutManager)
    let textContainer = NSTextContainer(size: self.bounds.size)
    textContainer.lineFragmentPadding = 0
    layoutManager.addTextContainer(textContainer)
    var glyphRange = NSRange(location: 0, length: 0)
    layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
    return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
  }
}

