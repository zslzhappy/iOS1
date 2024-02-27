//
//  UIScrollView+Extension.swift
//  
//
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import MJRefresh

//MARK: UIScrollView的扩展
public extension UIScrollView {
  
  /// 顶部刷新
  @available(*, deprecated, message: "Use setTopRefresh")
  @objc dynamic var topRefresh: () -> Void {
    set {
      let header = MJRefreshNormalHeader {
        newValue()
      }
      header.lastUpdatedTimeLabel?.isHidden = true
      header.stateLabel?.isHidden = true
      self.mj_header = header
    }
    get {
      return { }
    }
  }

  
  /// 底部刷新
  @available(*, deprecated, message: "Use setBottomRefresh")
  @objc dynamic var bottomRefresh: () -> Void {
    set {
      let footer = MJRefreshBackNormalFooter {
        newValue()
      }
      footer.stateLabel?.isHidden = true
      self.mj_footer = footer
    }

    get {
      return { }
    }
  }


  /// 开始顶部刷新
  @objc dynamic func beginTopRefresh() {
    guard let header = self.mj_header else {
      return
    }
    if header.isRefreshing {
      header.endRefreshing()
    }
    header.beginRefreshing()
  }

  /// 关闭顶部刷新
  @objc dynamic func closeTopRefresh() {
    if let header = self.mj_header {
      if header.isRefreshing {
        header.endRefreshing()
      }
    }
  }

  /// 开始底部刷新
  @objc dynamic func beginBottomRefresh() {
    guard let footer = self.mj_footer else {
      return
    }
    if footer.isRefreshing {
      footer.endRefreshing()
    }
    footer.beginRefreshing()
  }

  /// 关闭底部刷新
  @objc dynamic func closeBottomRefresh() {
    if let footer = self.mj_footer {
      if footer.isRefreshing {
        footer.endRefreshing()
      }
    }
  }

}
