//
//  Dictionary+Ext.swift
//
//
//  Copyright © 2018年 . All rights reserved.
//

import Foundation

public extension Dictionary {
  
  func jsonStringWithPrettyPrint() -> String? {
    
    guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
      
      print("data is nil")
      return nil
    }
    return String(data: data, encoding: .utf8)
  }
  
  func hasKey(_ key: Key) -> Bool {
    return index(forKey: key) != nil
  }

  mutating func merge(_ dict: [Key: Value]) {
    self.merge(dict) { (_, new) in new }
  }
  //MARK: merge时对不同的key做不同的处理
  /// 对不同的key可做不同处理
  @inlinable mutating func merge(with other: [Key : Value], uniquingKeysWith combine: (Key, Value, Value) throws -> Value) rethrows{
    other.keys.forEach { key in
      if self.hasKey(key){
        self[key] = try? combine(key,self[key]!,other[key]!)
      }else{
        self[key] = other[key]!
      }
    }
  }
  /// 过滤空字符串
  mutating func filterEmptyString(){
    self = filter { k,v in
      if let str = v as? String, str.isEmpty {
        return false
      }
      return true
    }
  }
}

