//
//  Array+Ext.swift
//  
//
//  Copyright © 2018年 . All rights reserved.
//

import Foundation

public extension Array {

  subscript(safe index: Int) -> Element? {
    return (0 ..< count).contains(index) ? self[index] : nil
  }

  func lastFewElement(_ number: Int) -> Array {
    if number >= count {
      return self
    }
    return Array(self[count - 1 - number + 1 ... count - 1])
  }
}

public extension Array where Element: Comparable {
  func containsSameElements(as other: [Element]) -> Bool {
    return self.count == other.count && self.sorted() == other.sorted()
  }
}

public extension Array where Element: Equatable {

  func isEqualNonStrictly(_ another: Self) -> Bool {
    guard count == another.count else {
      return false
    }
    for i in self {
      let index = another.firstIndex(of: i)
      if index == nil {
        return false
      }
    }

    for i in another {
      let index = firstIndex(of: i)
      if index == nil {
        return false
      }
    }
    return true
  }
  
  mutating func insert(_ mewElement:Element ,befor element :Element){
    if let index = self.firstIndex(of: element){
      self.insert(mewElement, at: index )
    }
  }
  
  func safeDropLast(_ k:Int)->Array{
    guard k > 0 else {
      return self
    }
    return Array(dropLast(Swift.min(k,self.count)))
  }

  /// 取前多少个元素
  func safePrefix(upTo end: Int)->Array{
    guard end > 0 , end <= count else {
      return self
    }
    return Array(prefix(upTo: end))
  }

}

