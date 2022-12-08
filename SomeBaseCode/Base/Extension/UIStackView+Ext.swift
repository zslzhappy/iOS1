//
//  UIStackView+Ext.swift
//  
//
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import UIKit

public extension UIStackView {
  
  func setStackViewBorderColor(_ color: UIColor){
    if #available(iOS 14.0, *) {
      layer.borderColor = color.cgColor
    } else {
      if let borderView = subviews.first(where: { $0.accessibilityIdentifier == "background" }) {
        borderView.layer.borderColor = color.cgColor
        borderView.frame = bounds
      } else {
        let borderView = UIView(frame: bounds)
        borderView.layer.borderColor = color.cgColor
        borderView.accessibilityIdentifier = "background"
        borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(borderView, at: 0)
      }
    }
  }
  
  func setStackViewBorderWidth(_ borderWidth: CGFloat){
    if #available(iOS 14.0, *) {
      layer.borderWidth = borderWidth
    } else {
      if let borderView = subviews.first(where: { $0.accessibilityIdentifier == "background" }) {
        borderView.layer.borderWidth = borderWidth
        borderView.frame = bounds
      } else {
        let borderView = UIView(frame: bounds)
        borderView.layer.borderWidth = borderWidth
        borderView.accessibilityIdentifier = "background"
        borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(borderView, at: 0)
      }
    }
  }
  
  func setStackViewCornerRadius(_ cornerRadius: CGFloat) {
    if #available(iOS 14.0, *) {
      layer.cornerRadius = cornerRadius
    } else {
      if let borderView = subviews.first(where: { $0.accessibilityIdentifier == "background" }) {
        borderView.layer.cornerRadius = cornerRadius
        borderView.frame = bounds
      } else {
        let borderView = UIView(frame: bounds)
        borderView.layer.cornerRadius = cornerRadius
        borderView.accessibilityIdentifier = "background"
        borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(borderView, at: 0)
      }
    }
  }
  
}

public extension UIStackView{
  class func swizzleMethod(){
    Toolbox.swizzleMethod(targetClass: self, originalSelector: #selector(setter: UIStackView.backgroundColor), swizzledSelector: #selector(setStackViewBackGroundColor(_:)))
  }
  
  @objc private func setStackViewBackGroundColor(_ color:UIColor){
    if #available(iOS 14.0, *) {
      setStackViewBackGroundColor(color)
    } else {
      if let backgroundView = subviews.first(where: { $0.accessibilityIdentifier == "background" }) {
        backgroundView.backgroundColor = color
      } else {
        let backgroundView = UIView(frame: bounds)
        backgroundView.accessibilityIdentifier = "background"
        backgroundView.backgroundColor = color
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(backgroundView, at: 0)
      }
    }
  }
}


public extension UIStackView{
  /// addArrangedSubview 并且设置常见的一些约束
  func addArrangedSubview(_ view:UIView,  constraints:UIViewSubViewConstraint ...){
    addArrangedSubview(view)
    for constraint in constraints{
      view.snp_makeContraints(constraint)
    }
  }
  
  func removeAllArrangedSubviews(){
    arrangedSubviews.forEach { v in
      self.removeArrangedSubview(v)
    }
  }
}
/// 容器view 用于做stackview的ArrangedSubview
public class MarginView:UIView{
  let contentView:UIView
  public init(_ view:UIView,frame:CGRect,topInset:CGFloat = 0,bottomInset:CGFloat = 0,leftInset:CGFloat = 0,rightInset:CGFloat = 0){
    self.contentView = view
    super.init(frame: frame)
    self.edge = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    addView(edge: edge)
  }
  private var edge : UIEdgeInsets = .zero

  public init(_ view:UIView,topInset:CGFloat = 0,bottomInset:CGFloat = 0,leftInset:CGFloat = 0,rightInset:CGFloat = 0){
    self.contentView = view
    super.init(frame:.zero)
    self.edge = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    addView(edge: edge)
  }
  
  public init(_ view:UIView,edgeInset:UIEdgeInsets){
    self.contentView = view
    super.init(frame:.zero)
    self.edge = edgeInset
    addView(edge: edge)
  }
  private func addView(edge:UIEdgeInsets){
    self.addSubV(contentView)
    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(edge)
    }
  }
  public func update(leftInset:CGFloat){
    edge.left = leftInset
    updateEdge()

  }
  public func update(rightInset:CGFloat){
    edge.right = rightInset
    updateEdge()

  }
  public func update(topInset:CGFloat){
    edge.top = topInset
    updateEdge()

  }
  public func update(bottomInset:CGFloat){
    edge.bottom = bottomInset
    updateEdge()

  }
  public func update(edge:UIEdgeInsets){
    self.edge = edge
    updateEdge()
  }
  
  private func updateEdge(){
    if contentView.superview.isSome{
      contentView.snp.remakeConstraints { make in
        make.edges.equalToSuperview().inset(edge)
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

public extension UIView{
  var marginSuperView:UIView?{
    if let s =  (self.superview as? MarginView){
      return s
    }
    return nil
  }
}
