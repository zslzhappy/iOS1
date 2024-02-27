//
//  UIView+Ext.swift
//  
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

public extension UIView {
  var x: CGFloat {
    get {
      return frame.origin.x
    }
    set {
      frame.origin.x = newValue
    }
  }

  var y: CGFloat {
    get {
      return frame.origin.y
    }
    set {
      frame.origin.y = newValue
    }
  }

  var w: CGFloat {
    get {
      return frame.size.width
    }
    set {
      frame.size.width = newValue
    }
  }

  var h: CGFloat {
    get {
      return frame.size.height
    }
    set {
      frame.size.height = newValue
    }
  }

  //  /origin
  var origin: CGPoint {
    get { return frame.origin }

    set(newValue) {
      var tmpFrame = frame
      tmpFrame.origin = newValue
      frame = tmpFrame
    }
  }

  //  /size
  var size: CGSize {
    get { return frame.size }

    set(newValue) {
      var tmpFrame = frame
      tmpFrame.size = newValue
      frame = tmpFrame
    }
  }

  //  / left
  var left: CGFloat {
    get { return frame.origin.x }

    set(newVal) {
      var tmpFrame = frame
      tmpFrame.origin.x = newVal
      frame = tmpFrame
    }
  }

  //  / right
  var right: CGFloat {
    get { return frame.origin.x + frame.size.width }

    set(newVal) {
      var tmpFrame = frame
      tmpFrame.origin.x = newVal - frame.size.width
      frame = tmpFrame
    }
  }

  //  / top
  var top: CGFloat {
    get { return frame.origin.y }

    set(newVal) {
      var tmpFrame = frame
      tmpFrame.origin.y = newVal
      frame = tmpFrame
    }
  }

  //  / bottom
  var bottom: CGFloat {
    get { return frame.origin.y + frame.size.height }

    set(newVal) {
      var tmpFrame = frame
      tmpFrame.origin.y = newVal - frame.size.height
      frame = tmpFrame
    }
  }

  //  /centerPosition
  var centerPosition: CGPoint {
    get { return center }

    set(newValue) { center = newValue }
  }

  //  / centerX
  var centerX: CGFloat {
    get { return center.x }
    set(newVal) { center = CGPoint(x: newVal, y: center.y) }
  }

  //  / centerY
  var centerY: CGFloat {
    get { return center.y }
    set(newVal) { center = CGPoint(x: center.x, y: newVal) }
  }

  //  / middleX
  var middleX: CGFloat { return bounds.width / 2 }

  //  / middleY
  var middleY: CGFloat { return bounds.height / 2 }

  //  / middlePoint
  var middlePoint: CGPoint { return CGPoint(x: bounds.width / 2, y: bounds.height / 2) }

  var maxX: CGFloat {
    return frame.maxX
  }

  var minX: CGFloat {
    return frame.minX
  }

  var maxY: CGFloat {
    set{
      frame.origin.y = newValue - frame.height
    }get{
      return frame.maxY
    }
  }

  var minY: CGFloat {
    return frame.minY
  }

  convenience init(width: CGFloat, height: CGFloat) {
    self.init(frame: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
  }

}


public extension UIView {
  //MARK: 约束获取
  /// 某约束 高、宽 ... (个别复杂UI 获取到的约束可能不符合预期)
  func constraintFixed(of attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
    if let cons = constraintIsFirstItem(of:attribute, in: superview?.constraints ?? []){
      return cons
    }
    if let cons = constraintIsFirstItem(of: attribute, in: constraints ){
      return cons
    }
    if let cons = constraintIsSecondItem(of:attribute, in: superview?.constraints ?? []){
      return cons
    }
    return constraintIsSecondItem(of:attribute, in: constraints)
  }

  
  private func constraintIsFirstItem(of attribute: NSLayoutConstraint.Attribute, in constraints: [NSLayoutConstraint]) -> NSLayoutConstraint? {
    let cons = constraints.first { constraint in
      if fixedAttributes(for: attribute).contains(constraint.firstAttribute), let firstItem = constraint.firstItem as? NSObject, firstItem == self {
        return true
      }
      return false
    }
    return cons
  }
  
  private func constraintIsSecondItem(of attribute: NSLayoutConstraint.Attribute, in constraints: [NSLayoutConstraint]) -> NSLayoutConstraint? {
    let cons = constraints.first { constraint in
      if fixedAttributes(for: attribute).contains(constraint.secondAttribute), let secondItem = constraint.secondItem as? NSObject, secondItem == self  {
        return true
      }
      return false
    }
    return cons
  }
  
  private func fixedAttributes(for attribute:NSLayoutConstraint.Attribute)->[NSLayoutConstraint.Attribute]{
    var attributes = [attribute]
    if attribute == .left{
      attributes.append(.leading)
    }else if attribute == .leading{
      attributes.append(.left)
    }else if attribute == .right{
      attributes.append(.trailing)
    }else if attribute == .trailing{
      attributes.append(.right)
    }
    return attributes
  }
  
}

public extension UIView {
  
  /// 递归获取所有子视图
  func allSubviews() -> [UIView] {
    var res = subviews // 1,2   3,4
    for subview in subviews {
      // subview = 1
      let riz = subview.allSubviews()
      // riz = 3,4
      res.append(contentsOf: riz)
    }
    return res
  }
  
  @discardableResult
  @objc func setBackColor(color: UIColor?) -> Self {
    backgroundColor = color
    return self
  }

  @discardableResult
  @objc func setBorderColor(color: UIColor?) -> Self {
    layer.borderColor = color?.cgColor
    return self
  }

  @discardableResult
  @objc func setBorderWidth(width: CGFloat) -> Self {
    layer.borderWidth = width
    return self
  }

  @discardableResult
  @objc func setLayerCornerR(radius: CGFloat) -> Self {
    layer.cornerRadius = radius
    return self
  }

  @discardableResult
  @objc func setMaskToBound(_ value: Bool) -> Self {
    layer.masksToBounds = value
    return self
  }

  @discardableResult
  @objc func setLayerCornerAndMaskToBounds(cornerradius: CGFloat) -> Self {
    layer.cornerRadius = cornerradius
    layer.masksToBounds = true
    return self
  }

  @discardableResult
  @objc func clips(toBounds: Bool) -> Self {
    clipsToBounds = toBounds
    return self
  }


  //MARK: 清除xib中label的文本内容
  func clearNibFileLabelText() {
    allSubviews().forEach { v in
      if let label = v as? UILabel {
        label.setText(nil)
      }
    }
  }

  //MARK: 清除xib中view的背景色
  func clearNibFileViewBackGroundColor() {
    allSubviews().forEach { v in
      v.setBackColor(color: nil)
    }
  }

  //MARK: 清除xib中view的背景色
  func clearNibFileViewBackGroundColor(excludeViews: [UIView]) {
    allSubviews().filter({ !excludeViews.contains($0) }).forEach { v in
      v.setBackColor(color: nil)
    }
  }

  //MARK: 清除xib中button的title
  func clearNibFileButtonTitle() {
    allSubviews().forEach { v in
      if let btn = v as? UIButton {
        btn.setTitle(nil, for: UIControl.State.normal)
      }
    }
  }
}

public extension UIView {
  @discardableResult
  func addSubV(_ view: UIView) -> Self {
    addSubview(view)
    return self
  }

  @discardableResult
  func addSubViews(_ views: [UIView]) -> Self {
    views.forEach { v in
      self.addSubview(v)
    }
    return self
  }

  /// 指定角切圆角
  func setCorner(roundedRect: CGRect, roundCorners: UIRectCorner, cornerRadius: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: roundedRect, byRoundingCorners: roundCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = roundedRect
    maskLayer.path = maskPath.cgPath
    layer.mask = maskLayer
  }

  /// 为view添加等高或等宽的渐变色layer,distance为layer的宽度或高度，closerColor为更靠近view里侧的颜色，fartherColor为靠外侧的颜色,orientation为layer在视图方位,outside为layer是否在view外部
  @discardableResult
  func addGradientColorLayer(distance: CGFloat, closerColor: UIColor, fartherColor: UIColor, orientation: ViewShadowOrientation, outside: Bool = true) ->CAGradientLayer{
    let colors = [closerColor.cgColor, fartherColor.cgColor]
    let gradient = CAGradientLayer()
    gradient.colors = colors
    var gradientFrame = CGRect.zero
    if orientation == .Top {
      gradientFrame = CGRect(x: 0, y: outside ? -distance : 0, width: w, height: distance)
      gradient.startPoint = CGPoint(x: 0, y: 1)
      gradient.endPoint = CGPoint(x: 0, y: 0)
    } else if orientation == .Bottom {
      gradientFrame = CGRect(x: 0, y: outside ? h : h - distance, width: w, height: distance)
      gradient.startPoint = CGPoint(x: 0, y: 0)
      gradient.endPoint = CGPoint(x: 0, y: 1)
    } else if orientation == .Left {
      gradientFrame = CGRect(x: outside ? -distance : 0, y: 0, width: distance, height: h)
      gradient.startPoint = CGPoint(x: 1, y: 0)
      gradient.endPoint = CGPoint(x: 0, y: 0)
    } else {
      gradientFrame = CGRect(x: outside ? w : w - distance, y: 0, width: distance, height: h)
      gradient.startPoint = CGPoint(x: 0, y: 0)
      gradient.endPoint = CGPoint(x: 1, y: 0)
    }
    gradient.frame = gradientFrame
    layer.insertSublayer(gradient, at: 0)
    if outside {
      layer.masksToBounds = false
    }
    return gradient
  }

}

public extension UIView {
  //MARK:  获取自动布局的视图的高
  /// 得到某一视图的自适应的高（调用系统方法 效率高于 func getHeightFor(limitWidth width: CGFloat) ） 求cell高则由cell的contentView调用此方法
  func getHeightFixedFor(limitWidth width: CGFloat) -> CGFloat {
    
    return systemLayoutSizeFitting(CGSize(width: width, height: 0),withHorizontalFittingPriority: .required,verticalFittingPriority: .fittingSizeLevel).height
    
  }
  
}

public protocol LoadViewFromNib where Self: UIView {
  static func createInstanceFromNib() -> Self?
}

extension UIView: LoadViewFromNib {
  public static func createInstanceFromNib() -> Self? {
    return Bundle.locatedBundle(for: self).loadViewFromNib(nibName: String(describing: self))
  }

  public static func nibName() -> String {
    return String(describing: self)
  }
}



/// 视图的一些常用约束
public enum UIViewSubViewConstraint{
  /// leading trailing 和父视图相同
  case leadingTrailingEqual
  /// top bottom 和父视图相同
  case topBottomEqual
  /// leading top 和父视图相同
  case leadingTopEqual
  /// trailing top 和父视图相同
  case trailingTopEqual
  /// leading  和父视图相同
  case leadingEqual
  /// trailing 和父视图相同
  case trailingEqual
  /// trailing 和父视图相同或小于
  case trailingLessOrEqual
  /// top 和父视图相同
  case topEqual
  /// bottom 和父视图相同
  case bottomEqual
  /// center 和父视图相同
  case centerEqual
  /// centerY 和父视图相同
  case centerYEqual
  /// centerX 和父视图相同
  case centerXEqual
  /// bottom 和父视图相同或小于
  case bottomLessOrEqual
  /// width 和父视图相同
  case widthEqual
  /// width 和父视图相同或小于
  case widthLessOrEqual
  /// height 和父视图相同
  case heightEqual
  /// height 和父视图相同或小于
  case heightLessOrEqual
  /// 和父视图等大
  case edgesEqual
  /// left
  case left( _ left:CGFloat)
  /// top
  case top( _ value:CGFloat)
  /// bottom
  case bottom( _ value:CGFloat)
  /// right
  case right( _ value:CGFloat)
  /// 宽
  case width(_ width:CGFloat)
  /// 高
  case height(_ height:CGFloat)
  /// size
  case size( w:CGFloat, h:CGFloat)

}

public extension UIView{
  
  //MARK: 添加子视图并设置约束
  @discardableResult
  func addSubView(_ view:UIView,makeConstraints closure:(_ make: ConstraintMaker) -> Void) -> Self{
    self.addSubV(view)
    view.snp.makeConstraints(closure)
    return self
  }

  // MARK: 不定参数为子视图设置多个约束或不设置约束
  /// 添加子视图并设置常见约束
  @discardableResult
  func addSubView(_ view:UIView,constraints:UIViewSubViewConstraint ...) -> Self{
    self.addSubV(view)
    for constraint in constraints{
      view.snp_makeContraint(constraint)
    }
    return self
  }
  /// 设置常见约束
  func snp_makeContraints(_ constraints:UIViewSubViewConstraint...){
    for constraint in constraints{
      snp_makeContraint(constraint)
    }
  }
  
  /// 设置常见约束
  func snp_makeContraints(_ closure:(_ make: ConstraintMaker) -> Void){
    snp.makeConstraints(closure)
  }
  
  /// 设置常见约束
  private func snp_makeContraint(_ constraint:UIViewSubViewConstraint){
    self.snp.makeConstraints { make in
      switch constraint {
      case .leadingTrailingEqual:
        make.leading.trailing.equalToSuperview()
      case .leadingEqual:
        make.leading.equalToSuperview()
      case .trailingEqual:
        make.trailing.equalToSuperview()
      case .leadingTopEqual:
        make.leading.top.equalToSuperview()
      case .trailingTopEqual:
        make.trailing.top.equalToSuperview()
      case .trailingLessOrEqual:
        make.trailing.lessThanOrEqualToSuperview()
      case .topBottomEqual:
        make.top.bottom.equalToSuperview()
      case .topEqual:
        make.top.equalToSuperview()
      case .bottomEqual:
        make.bottom.equalToSuperview()
      case .bottomLessOrEqual:
        make.bottom.lessThanOrEqualToSuperview()
      case .widthEqual:
        make.width.equalToSuperview()
      case .widthLessOrEqual:
        make.width.lessThanOrEqualToSuperview()
      case .heightEqual:
        make.height.equalToSuperview()
      case .heightLessOrEqual:
        make.height.lessThanOrEqualToSuperview()
      case .width(let w):
        make.width.equalTo(w)
      case .height(let h):
        make.height.equalTo(h)
      case .size(let w,let h):
        make.size.equalTo(CGSize(width: w, height: h))
      case .edgesEqual:
        make.edges.equalToSuperview()
      case .centerEqual:
        make.center.equalToSuperview()
      case .centerXEqual:
        make.centerX.equalToSuperview()
      case .centerYEqual:
        make.centerY.equalToSuperview()
      case .left(let value):
        make.left.equalTo(value)
      case .top(let value):
        make.top.equalTo(value)
      case .bottom( let value):
        make.bottom.equalTo(value)
      case .right(let value):
        make.right.equalTo(value)
      }
    }
  }
  
}

public extension UIView{
  //MARK: 利用RxSwift添加tap手势
  func addTapGesture(_ tapHandler:@escaping()->()){
    isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer()
    addGestureRecognizer(tap)
    tap.rx.event.subscribe(onNext: { (_) in
      tapHandler()
    }).disposed(by: self.disposedBag)
  }
}



public enum ViewShadowOrientation {
  case Top
  case Bottom
  case Left
  case Right
}



extension ConstraintViewDSL{
  // 若未设置过约束 直接调用remakeConstraints(_:)会闪退
  //MARK: 安全地remak约束
  public func safeRemakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
    makeConstraints { _ in
    }
    remakeConstraints(closure)
  }
}
