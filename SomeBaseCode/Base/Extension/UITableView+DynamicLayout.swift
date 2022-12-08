//
//  UITableView+DynamicLayout.swift
//  UITableViewDynamicLayout
//
//

import UIKit


extension UITableView{
  
  public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, indexPath: IndexPath) -> T {
    let cell = dequeueReusableCell(withIdentifier: type.reuse_identifier)
    if cell.isSome { return cell as! T }
    let bundle = Bundle.locatedBundle(for: type.classForCoder())
    if let _ = bundle.path(forResource: type.className, ofType: "nib") {
      register(UINib(nibName: type.className, bundle: bundle), forCellReuseIdentifier: type.reuse_identifier)
      return dequeueReusableCell(withIdentifier: type.reuse_identifier, for: indexPath) as! T
    }
    register(type.self, forCellReuseIdentifier: type.reuse_identifier)
    return dequeueReusableCell(withIdentifier: type.reuse_identifier, for: indexPath) as! T
  }

  public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type) -> T {
    let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier)
    if cell != nil { return cell as! T }
    let bundle = Bundle(for: type.classForCoder())
    if let _ = bundle.path(forResource: type.className, ofType: "nib") {
      register(UINib(nibName: type.className, bundle: bundle), forCellReuseIdentifier: type.reuseIdentifier)
      return dequeueReusableCell(withIdentifier: type.reuseIdentifier) as! T
    }
    register(type.self, forCellReuseIdentifier: type.reuseIdentifier)
    return dequeueReusableCell(withIdentifier: type.reuseIdentifier) as! T
  }

  public func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(for type: T.Type) -> T {
    let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier)
    if headerFooterView != nil { return headerFooterView as! T }
    let bundle = Bundle(for: type.classForCoder())
    if let _ = bundle.path(forResource: type.className, ofType: "nib") {
      register(UINib(nibName: type.className, bundle: bundle), forCellReuseIdentifier: type.reuseIdentifier)
      return dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as! T
    }
    register(type.self, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    return dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as! T
  }
  
}

extension UITableViewCell {
  public class var reuseIdentifier: String {
    NSStringFromClass(self)
  }
}

