//
//  File.swift
//  
//
//  Copyright © 2022 . All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import RxGesture
extension ObservableType{
  /*
   
  cell.rx.tapGesture().when(.recognized).subscribe({ _ in
     
  })
  cell为某一tableView上的一个cell
  以上代码有问题(可观察序列 发出元素 和
  completed的时候 订阅的闭包都会走 ，此处的具体表现就是
  cell销毁的时候这个回调也会走(可观察序列销毁的时候会发送一次completed）但本意显然是想点击了UI元素的时候（发出元素）才执行回调）
                    
  故为ObservableType 添加以下方法
   */
  public func subscribeOnNext(onNext: @escaping ((Element) -> Void)) -> Disposable{
    return subscribe(onNext: onNext)
  }
}


