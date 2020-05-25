//
//  TXWaveTransition.swift
//  Pods-TXTransitionSwift_Example
//
//  Created by 张雄 on 2020/5/21.
//

import UIKit

/// 波浪式的转场动画
open class TXWaveTransition: NSObject, TXTransitionSwift, CAAnimationDelegate {
    
    public var type: TXTransitionType
    
    public required init(type transitionType: TXTransitionType) {
        self.type = transitionType
    }
    
    ///
    /// 构造方法
    ///
    /// - Parameters:
    ///   - transitionType: 转场类型
    ///   - touchPoint: 位置
    ///
    public init (type transitionType: TXTransitionType,point touchPoint: CGPoint) {
        self.type = transitionType
        self.point = touchPoint
    }
    
    /// 位置
    public var point: CGPoint = .init(x: 0.0, y: 0.0)
    
    /// 转场上下文(私有属性)
    private var transitionContext: UIViewControllerContextTransitioning?
 
    public func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) -> Void {
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
    
    public func dissmissAnimation(using transitionContext: UIViewControllerContextTransitioning) -> Void {
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
