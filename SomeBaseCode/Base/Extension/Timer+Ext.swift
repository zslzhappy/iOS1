//
//  File.swift
//  
//
//  Created by thor.wang on 2019/11/26.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

public extension Timer {
  //MARK: 解决计时器和target之间循环引用的问题
  /// 使用block的方式创建一个timer(适配ios9及以上)  block内的引用对象避免强引用
  static func safeRetainSheduledTimer(timeInterval ti: TimeInterval, block: @escaping () -> Void, userInfo: Any?, repeats yesOrNo: Bool) -> Timer {
    let executor = InnerExecutor()
    executor.block = block
    let timer = Timer.scheduledTimer(timeInterval: ti, target: executor, selector: #selector(InnerExecutor.excute), userInfo: userInfo, repeats: yesOrNo)
    return timer
  }

  /// 创建一个timer(适配ios9及以上)  block内的引用对象避免强引用
  static func safeRetainTimer(fireAt date: Date, interval: TimeInterval, block: @escaping () -> Void, userInfo: Any?, repeats: Bool) -> Timer {
    let executor = InnerExecutor()
    executor.block = block
    return Timer(fireAt: date, interval: interval, target: executor, selector: #selector(InnerExecutor.excute), userInfo: userInfo, repeats: repeats)
  }

  /// 暂停
  func pause(){
    fireDate = Date.distantFuture
  }
  
  /// 继续
  func resume(){
    fireDate = Date()
  }
  
}

private class InnerExecutor {
  var block: () -> Void = {}
  @objc func excute() {
    block()
  }
}
