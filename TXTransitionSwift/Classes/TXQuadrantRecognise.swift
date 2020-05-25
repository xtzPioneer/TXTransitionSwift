//
//  TXQuadrantRecognise.swift
//  Pods-TXTransitionSwift_Example
//
//  Created by 张雄 on 2020/5/25.
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
