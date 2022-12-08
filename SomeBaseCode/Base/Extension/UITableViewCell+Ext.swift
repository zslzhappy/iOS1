//
//  File.swift
//  
//
//  Created by thor.wang on 2019/4/26.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

public extension UITableViewCell{
  class var reuse_identifier:String{
    return NSStringFromClass(self)
  }
  ///  清除重用标识符
  func clearReuseIdentifier(){
    setValue(nil, forKey: "reuseIdentifier")
  }
  
}

public extension UICollectionViewCell{
  class var reuse_identifier:String{
    return NSStringFromClass(self)
  }
}

public extension UICollectionReusableView{
  class var reuseIdentifier:String{
    return NSStringFromClass(self)
  }
}

public extension UITableViewHeaderFooterView{
  class var reuseIdentifier:String{
    return NSStringFromClass(self)
  }
}




@available(iOS 14.0, *)
extension UITableViewCell {
  // ios14 会将contentView置于cell最顶部 若子视图直接添加于cell上 则交互被阻断
  class func fixViewHierarchyBug(){
    Toolbox.swizzleMethod(targetClass: UITableViewCell.self, originalSelector: #selector(addSubview(_:)), swizzledSelector: #selector(customAddSubview(_:)))
  }
  @objc func customAddSubview(_ view:UIView){
    customAddSubview(view)
    if !NSStringFromClass(view.classForCoder).contains("UITableViewCellContentView")
        {
      contentView.isHidden = contentView.subviews.count == 0
    }
  }
}
