//
//  RunLoop+Ext.swift
//  
//
//  Created by thor.wang on 2019/12/17.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

public extension RunLoop{

  func perform(block:@escaping ()->(),order:Int,modes:[RunLoop.Mode]){
    let target = InnerTarget()
    target.block = block
    self.perform(#selector(target.excute), target: target, argument: nil, order: order, modes: modes)
  }
  
  class InnerTarget {
    var block = {}
    @objc func excute(){
      block()
    }
  } 
}
