//
//  Optional+Ext.swift
//  
//
//  Copyright © 2018 . All rights reserved.
//

import Foundation
//MARK: Optional的一些扩展
public extension Optional {
  /// 可选值为空的时候返回 true
  var isNone: Bool {
    switch self {
    case .none:
      return true
    case .some:
      return false
    }
  }
  
  /// 可选值非空返回 true
  var isSome: Bool {
    return !isNone
  }
}

public extension Optional {
  /// 返回可选值或默认值
  /// - 参数: 如果可选值为空，将会默认值
  func or(_ default: Wrapped) -> Wrapped {
    return self ?? `default`
  }
  
  /// 返回可选值或 `else` 表达式返回的值
  /// 例如. optional.or(else: print("Arrr"))
  func or(else: @autoclosure () -> Wrapped) -> Wrapped {
    return self ?? `else`()
  }
  
  /// 返回可选值或者 `else` 闭包返回的值
  // 例如. optional.or(else: {
  /// ... do a lot of stuff
  /// })
  func or(else: () -> Wrapped) -> Wrapped {
    return self ?? `else`()
  }
}

public extension Optional {
  /// 可选值变换返回，如果可选值为空，则返回默认值
  /// - 参数 fn: 映射值的闭包
  /// - 参数 default: 可选值为空时，将作为返回值
  func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T {
    return try map(fn) ?? `default`
  }
  
  /// 可选值变换返回，如果可选值为空，则调用 `else` 闭包
  /// - 参数 fn: 映射值的闭包
  /// - 参数 else: The function to call if the optional is empty
  func map<T>(_ fn: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
    return try map(fn) ?? `else`()
  }
}

public extension Optional {
  ///  当可选值不为空时，解包并返回参数 `optional`
  func and<B>(_ optional: B?) -> B? {
    guard self != nil else { return nil }
    return optional
  }
  
  /// 解包可选值，当可选值不为空时，执行 `then` 闭包，并返回执行结果
  /// 允许你将多个可选项连接在一起
  func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
    guard let unwrapped = self else { return nil }
    return try then(unwrapped)
  }
}

public extension Optional {
  /// 当可选值不为空时，执行 `some` 闭包
  func on(some: () throws -> Void) rethrows {
    if self != nil { try some() }
  }
  
  /// 当可选值为空时，执行 `none` 闭包
  func on(none: () throws -> Void) rethrows {
    if self == nil { try none() }
  }
}
