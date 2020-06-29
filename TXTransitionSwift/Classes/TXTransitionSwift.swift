//
//  TXTransitionSwift.swift
//  Pods-TXTransitionSwift_Example
//
//  Created by 张雄 on 2020/5/22.
//

import UIKit

/// 转场类型
public enum TXTransitionType {
    /// present
    case present
    /// dissmiss
    case dissmiss
}

/// 转场动画
public protocol TXTransitionSwift: UIViewControllerAnimatedTransitioning {
    /// 转场类型
    var type: TXTransitionType { get set }
    ///
    /// present动画
    ///
    /// - Parameters:
    ///   - transitionContext: 转场上下文
    ///
    func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) -> Void
    ///
    /// dissmiss动画
    ///
    /// - Parameters:
    ///   - transitionContext: 转场上下文
    ///
    func dissmissAnimation(using transitionContext: UIViewControllerContextTransitioning) -> Void
    ///
    /// 构造方法
    ///
    /// - Parameters:
    ///   - transitionType: 转场类型
    ///
    init(type transitionType: TXTransitionType)
}

