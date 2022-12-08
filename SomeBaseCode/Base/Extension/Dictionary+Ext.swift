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

public extension Dictionary {
  mutating func merge( _ value: String,key:Key,separator:String = ",") {
    if let v = self[key] as? String{
      self[key] = (v + separator + value) as? Value
    }else{
      self[key] = value as? Value
    }
  }
}

/// [String:Any]类型生成唯一的描述字符串
public extension  Dictionary {
  func sortedDescription() -> String {
    guard let self = self as? [String:Any] else {
      return ""
    }
    var parametersArray = [String]()
    let sortedKeysMap = self.sorted(by: { $0.key.localizedStandardCompare($1.key) == ComparisonResult.orderedAscending })
    sortedKeysMap.forEach { (k,v) in
      if let value = v as? [String: Any] {
        parametersArray.append("\"\(k)\":\(value.sortedDescription())")
      } else if let values = v as? [[String: Any]] {
        var arr =  [String]()
        values.forEach({ (map) in
          arr.append("\(map.sortedDescription())")
        })
        let s = "{\(arr.joined(separator: ","))}"
        parametersArray.append("\"\(k)\":\(s)")
      } else if let value = v as? [Any] {
        parametersArray.append("\"\(k)\":\(value)")
      } else {
        parametersArray.append("\"\(k)\":\"\(v)\"")
      }
    }
    return"{\(parametersArray.joined(separator: ","))}"
  }
}


