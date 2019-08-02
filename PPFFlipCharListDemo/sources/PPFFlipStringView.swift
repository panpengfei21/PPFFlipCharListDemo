//
//  PPFFlipStringView.swift
//  PPFFlipCharListDemo
//
//  Created by 潘鹏飞 on 2019/8/2.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit
import PPFFlipChar
import PPFEquableItemsView

public class PPFFlipStringView: UIView {

    /// 容器
    weak var container:PPFEquableItemsView!

    /// 有几个字符
    let numberOfChar:Int
    /// 字符之间的空隙
    let charSpace:CGFloat
    /// 方向
    let containerDirection:PPFEquableItemsView.Direction
    
    
    public init(frame: CGRect,number:Int,charSpace:CGFloat,direction:PPFEquableItemsView.Direction) {
        self.numberOfChar = number
        self.charSpace = charSpace
        self.containerDirection = direction
        super.init(frame: frame)
        
        initializeUIs()
        initializeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUIs() {
        container = {
            let v = PPFEquableItemsView(frame: CGRect.zero, direction: containerDirection, dataSource: self, itemsSpace: charSpace)
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
            return v
        }()
        container.reloadDataSources()
    }
    private func initializeConstraints() {
        container.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}

// MARK: - PPFEquableItemsViewDataSource
extension PPFFlipStringView:PPFEquableItemsViewDataSource {
    public func equableItemsNumberIn(eView: PPFEquableItemsView) -> Int {
        return numberOfChar
    }
    
    public func equableItems(eView: PPFEquableItemsView, viewAtIndex index: Int) -> UIView {
        let v = PPFFlipCharView(frame: CGRect.zero, char: Character(" "))
        return v
    }
}

extension PPFFlipStringView {
    /// 设置字体
    public func setTextFont(_ font:UIFont) {
        for v in container.subviews {
            let fv = v as! PPFFlipCharView
            fv.topCharFont = font
            fv.bottomCharFont = font
        }
    }
    /// 设置字符颜色
    public func setTextColor(_ color:UIColor) {
        for v in container.subviews {
            let fv = v as! PPFFlipCharView
            fv.topCharColor = color
            fv.bottomCharColor = color
        }
    }
    /// 设置字符背景颜色
    public func setTextBackgroundColor(_ color:UIColor){
        for v in container.subviews {
            let fv = v as! PPFFlipCharView
            fv.topCharBackgroundColor = color
            fv.bottomCharBackground = color
        }
    }
    /// 设置字符时面空隙的距离
    public func setSpaceInsideChar(_ space:CGFloat){
        for v in container.subviews {
            let fv = v as! PPFFlipCharView
            fv.interspace = space
        }
    }
    /// 设置上半部动画时间
    public func setTopDuration(_ duration:Double){
        for v in container.subviews {
            let fv = v as! PPFFlipCharView
            fv.topVAnimationDuration = duration
        }
    }
    /// 设置下半部动画时间
    public func setBottomDuration(_ duration:Double) {
        for v in container.subviews {
            let fv = v as! PPFFlipCharView
            fv.bottomVAnimationDuration = duration
        }
    }
    
    /// 设置文本
    @discardableResult
    public func setText(_ text:String,force:Bool,animate:Bool = true) -> Bool{
        let need = numberOfChar - text.count
        guard need >= 0 else {
            print("PPFFlipStringView:设置的文本长度(\(text.count)),不能大于预定值(\(numberOfChar))")
            return false
        }
        
        let r = String(repeating: Character(" "), count: need) + text
        
        let chars:[Character] = r.suffix(numberOfChar)
        for i in 0 ..< numberOfChar {
            let fv = container.subviews[i] as! PPFFlipCharView
            fv.convertToChar(chars[i],force: force, animation: animate)
        }
        
        return true
    }
}
