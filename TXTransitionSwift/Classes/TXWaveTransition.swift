//
//  TXWaveTransition.swift
//  Pods-TXTransitionSwift_Example
//
//  Created by 张雄 on 2020/5/21.
//

import UIKit

/// 现象样式
public enum TXQuadrantStyle {
    /// 第一象限
    case first
    /// 第二象限
    case second
    /// 第三象限
    case third
    /// 第四象限
    case fourth
}

/// 现象样式扩展
extension TXQuadrantStyle {
    ///
    /// 计算半径
    ///
    /// - Parameters:
    ///   - touchPoint: 位置
    /// - Returns
    ///   CGFloat 半径
    ///
    public func radius(point touchPoint: CGPoint) -> CGFloat {
        switch self {
        case .first:
            return sqrt(touchPoint.x * touchPoint.x + (UIScreen.main.bounds.size.height - touchPoint.y) * (UIScreen.main.bounds.size.height - touchPoint.y));
        case .second:
            return sqrt((UIScreen.main.bounds.size.width - touchPoint.x) * (UIScreen.main.bounds.size.width - touchPoint.x)  + (UIScreen.main.bounds.size.height - touchPoint.y) * (UIScreen.main.bounds.size.height - touchPoint.y));
        case .third:
            return sqrt((UIScreen.main.bounds.size.width - touchPoint.x) * (UIScreen.main.bounds.size.width - touchPoint.x)  + touchPoint.y * touchPoint.y);
        case .fourth:
            return sqrt(touchPoint.x * touchPoint.x  + touchPoint.y * touchPoint.y);
        }
    }
}

/// 现象识别
open class TXQuadrantRecognise {
    
    /// 样式 (私有存储属性)
    private var quadrantStyle: TXQuadrantStyle  = .first
    
    /// 样式(公开计算属性)
    public var style: TXQuadrantStyle {
        get {
            return self.quadrantStyle
        }
    }
    
    ///
    /// 识别
    ///
    /// - Parameters:
    ///   - touchPoint: 位置
    /// - Returns
    ///   CGFloat 半径
    ///
    public func recognise(point touchPoint: CGPoint) -> CGFloat {
        if (touchPoint.x >= UIScreen.main.bounds.size.width / 2) {
            if (touchPoint.y >= UIScreen.main.bounds.size.height / 2) {
                self.quadrantStyle = .fourth;
            }else{
                self.quadrantStyle = .first;
            }
        }else{
            if (touchPoint.y >= UIScreen.main.bounds.size.height / 2) {
                self.quadrantStyle = .third;
            }else{
                self.quadrantStyle = .second;
            }
        }
        return self.style.radius(point: touchPoint)
    }
    
    ///
    /// 识别
    ///
    /// - Parameters:
    ///   - touchPoint: 位置
    /// - Returns
    ///   CGFloat 半径
    ///
    class func recognise(point touchPoint: CGPoint) -> CGFloat {
        return TXQuadrantRecognise.init().recognise(point: touchPoint)
    }
}

/// 波浪式的转场动画
open class TXWaveTransition: NSObject, UIViewControllerAnimatedTransitioning, UICollectionViewDelegate, CAAnimationDelegate {
    
    /// 转场类型
    public enum TXWTTransitionType {
        /// present
        case present
        /// dissmiss
        case dissmiss
    }
    
    /// 转场类型
    public var type: TXWTTransitionType = .present
    
    /// 位置
    public var point: CGPoint = .init(x: 0.0, y: 0.0)
    
    /// 转场上下文(私有属性)
    private var transitionContext: UIViewControllerContextTransitioning?
    
    ///
    /// 构造方法
    ///
    /// - Parameters:
    ///   - transitionType: 转场类型
    ///   - touchPoint: 位置
    ///
    public init(type transitionType:TXWTTransitionType, point touchPoint: CGPoint) {
        self.type = transitionType
        self.point = touchPoint
    }
    
    ///
    /// present动画
    ///
    /// - Parameters:
    ///   - transitionContext: 转场上下文
    ///
    private func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) -> Void {
        // 设置toVC
        let toVC: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        toVC.view!.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        transitionContext.containerView.addSubview(toVC.view)
        // 绘制路径
        let initPath: UIBezierPath = .init(rect: .init(origin: self.point, size: .init(width: 0.0, height: 0.0)))
        let radius: CGFloat = TXQuadrantRecognise.recognise(point: self.point)
        let finalRect: CGRect = CGRect(x: self.point.x, y: self.point.y, width: 0, height: 0).insetBy(dx: -radius, dy: -radius)
        let finalPath: UIBezierPath = .init(roundedRect: finalRect, cornerRadius: radius)
        // 创建动画层
        let maskLayer: CAShapeLayer = .init()
        maskLayer.path = finalPath.cgPath;
        toVC.view.layer.mask = maskLayer;
        // 准备动画
        let basicAnim: CABasicAnimation = .init(keyPath: "path")
        basicAnim.fromValue = initPath.cgPath
        basicAnim.toValue = finalPath.cgPath
        basicAnim.delegate = self;
        basicAnim.duration = self.transitionDuration(using: transitionContext)
        // 添加动画
        maskLayer.add(basicAnim, forKey: "path")
    }
    
    ///
    /// dissmiss动画
    ///
    /// - Parameters:
    ///   - transitionContext: 转场上下文
    ///
    private func dissmissAnimation(using transitionContext: UIViewControllerContextTransitioning) -> Void {
        // 设置fromVC
        let fromVC: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        // 绘制路径
        let initPath: UIBezierPath = .init(rect: .init(origin: self.point, size: .init(width: 0.0, height: 0.0)))
        let radius: CGFloat = TXQuadrantRecognise.recognise(point: self.point)
        let finalRect: CGRect = CGRect(x: self.point.x, y: self.point.y, width: 0, height: 0).insetBy(dx: -radius, dy: -radius)
        let finalPath: UIBezierPath = .init(roundedRect: finalRect, cornerRadius: radius)
        // 创建动画层
        let maskLayer: CAShapeLayer = .init()
        maskLayer.path = initPath.cgPath;
        fromVC.view.layer.mask = maskLayer;
        // 准备动画
        let basicAnim: CABasicAnimation = .init(keyPath: "path")
        basicAnim.fromValue = finalPath.cgPath
        basicAnim.toValue = initPath.cgPath
        basicAnim.delegate = self;
        basicAnim.duration = self.transitionDuration(using: transitionContext)
        // 添加动画
        maskLayer.add(basicAnim, forKey: "path")
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.transitionContext?.completeTransition(true)
        }
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext;
        switch self.type {
        case .present:
            self.presentAnimation(using: transitionContext)
        case .dissmiss:
           self.dissmissAnimation(using: transitionContext)
        }
    }
}
