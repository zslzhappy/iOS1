//
//  URL+Ext.swift
//  
//
//

import UIKit

public extension URL {
  func getQueryValue(_ key: String) -> String {
    guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
      return ""
    }
    guard let queryItems = components.queryItems else {
      return ""
    }
    if let item = queryItems.filter({$0.name == key}).first {
      return item.value ?? ""
    }
    return ""
  }
}
