//
//  NextViewController.swift
//  TXTransitionSwift_Example
//
//  Created by 张雄 on 2020/5/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import TXTransitionSwift

class NextViewController: UIViewController,UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注意这两个属性必须设置
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 转场动画1
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return TXWXTransitionSwift(type: .present)
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return TXWXTransitionSwift(type: .dissmiss)
//    }
    
    // 转场动画2
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TXWaveTransition(type: .present, point: .init(x: 207, y: 333))
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TXWaveTransition(type: .dissmiss, point: .init(x: 207, y: 333))
    }
    
}
