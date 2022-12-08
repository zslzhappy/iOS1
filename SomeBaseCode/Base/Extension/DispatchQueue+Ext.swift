//
//  File.swift
//  
//
//  Created by thor.wang on 2021/8/3.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

public extension DispatchQueue {
  /// 在不同队列异步执行
  static func asyncExcuteOnDifferentQueue( _  block:@escaping ()->()){
    if Thread.isMainThread{
      DispatchQueue.global().async{
        block()
      }
    }else{
      DispatchQueue.main.async {
        block()
      }
    }
  }
  
  /// 在不同队列多少秒后异步执行
  static func asyncExcuteOnDifferentQueue( _  block:@escaping ()->(),after:Int){
    if Thread.isMainThread{
      DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(after)){
        block()
      }
    }else{
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(after)) {
        block()
      }
    }
  }
}
