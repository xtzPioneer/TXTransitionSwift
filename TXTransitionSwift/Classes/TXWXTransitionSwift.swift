//
//  TXWXTransitionSwift.swift
//  TXWXTransitionSwift
//
//  Created by 张雄 on 2020/5/20.
//  Copyright © 2020 张雄. All rights reserved.
//

import UIKit

/// 仿微信小程序转场动画Swift版本.
open class TXWXTransitionSwift: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// 转场类型
    public enum TXWXTransitionType {
        /// present
        case present
        /// dissmiss
        case dissmiss
    }
    
    /// 转场类型
    public var type: TXWXTransitionType  = .present
    
    ///
    /// 构造方法
    ///
    /// - Parameters:
    ///   - transitionType: 转场类型.
    ///
    public init(type transitionType: TXWXTransitionType) {
        self.type = transitionType
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    ///
    /// present动画
    ///
    /// - Parameters:
    ///   - transitionContext: 转场上下文.
    ///
    private func presentAnimation <T: UIViewControllerContextTransitioning> (using transitionContext: T) -> Void {
        // 设置toVC
        let toVC: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        toVC.view!.frame = .init(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        transitionContext.containerView.addSubview(toVC.view)
        toVC.view.layer.zPosition = CGFloat(MAXFLOAT)
        // 设置fromVC
        let fromVC: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        fromVC.view.layer.frame = .init(x:0, y: UIScreen.main.bounds.size.height / 2, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        fromVC.view.layer.zPosition = -1;
        fromVC.view.layer.anchorPoint = .init(x: 0.5, y: 1)
        // 旋转
        var rotate: CATransform3D = CATransform3DIdentity
        rotate.m34 = -1.0 / 1000.0;
        let coefficient: CGFloat = UIScreen.main.bounds.size.height >= 812.0 ? 5.0 : 3.0
        rotate = CATransform3DRotate(rotate, coefficient * CGFloat.pi / 180.0, 1, 0, 0)
        // 动画1
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromVC.view.layer.transform = rotate;
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        // 动画2
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            var frame:CGRect = toVC.view.frame
            frame.origin.y = UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height;
            toVC.view.frame = frame;
        }, completion: nil)
    }
    
    ///
    /// dissmiss动画
    ///
    /// - Parameters:
    ///   - transitionContext: 转场上下文.
    ///
    private func dissmissAnimation <T: UIViewControllerContextTransitioning> (using transitionContext: T) -> Void {
        // 设置toVC
        let toVC: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        // 设置fromVC
        let fromVC: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        // 旋转
        var rotate: CATransform3D = CATransform3DIdentity
        rotate.m34 = -1.0 / 1000.0;
        let coefficient: CGFloat = UIScreen.main.bounds.size.height >= 812.0 ? 5.0 : 3.0
        rotate = CATransform3DRotate(rotate, coefficient * CGFloat.pi / 180.0, 1, 0, 0)
        // 动画1
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            toVC.view.layer.transform = rotate;
        }) { (finished) in
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                toVC.view.layer.transform = CATransform3DIdentity;
            }) { (finished) in
                toVC.view.layer.anchorPoint = .init(x: 0.5, y: 0.5)
                toVC.view.layer.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                transitionContext.completeTransition(true)
            }
        }
        // 动画2
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            var frame: CGRect = fromVC.view.frame;
            frame.origin.y = UIScreen.main.bounds.size.height
            fromVC.view.frame = frame;
        }, completion: nil)
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.type {
            case .present:
                self.presentAnimation(using: transitionContext)
            case .dissmiss:
                self.dissmissAnimation(using: transitionContext)
        }
    }
}
