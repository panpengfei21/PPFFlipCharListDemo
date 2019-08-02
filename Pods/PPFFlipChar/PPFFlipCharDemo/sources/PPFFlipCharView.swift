//
//  OneNumberV.swift
//  NumberDemo
//
//  Created by 潘鹏飞 on 2019/7/29.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit

@objc public class PPFFlipCharView: UIView {
    var char:Character
    
    /// 景深
    let m34:CGFloat = -1.0/500.0

    /// 上部字符字体
    @objc public var topCharFont:UIFont {
        get {
            return topV.charLabel.font
        }
        set {
            topV.charLabel.font = newValue
        }
    }
    /// 下部字符字体
    @objc public var bottomCharFont:UIFont {
        get {
            return bottomV.charLabel.font
        }
        set {
            bottomV.charLabel.font = newValue
        }
    }


    /// 上部字符颜色
    @objc public var topCharColor:UIColor {
        get {
            return topV.charLabel.textColor
        }
        set {
            topV.charLabel.textColor = newValue
        }
    }
    
    /// 下部字符颜色
    @objc public var bottomCharColor:UIColor {
        get {
            return bottomV.charLabel.textColor
        }
        set {
            bottomV.charLabel.textColor = newValue
        }
    }
    
    /// 上部字符背景颜色
    @objc public var topCharBackgroundColor:UIColor? {
        get {
            return topV.charLabel.backgroundColor
        }
        set {
            topV.charLabel.backgroundColor = newValue
        }
    }
    /// 下部字符背景颜色
    @objc public var bottomCharBackground:UIColor? {
        get{
            return bottomV.charLabel.backgroundColor
        }
        set {
            bottomV.charLabel.backgroundColor = newValue
        }
    }
    
    /// 上下部分的空隙
    @objc public var interspace:CGFloat = 5 {
        didSet{
            topVConstraint.constant = interspace / -2
            bottomVConstraint.constant = interspace / 2
            
            topV.setLabelUpOrDownConstraint(constant: interspace / 2)
            bottomV.setLabelUpOrDownConstraint(constant: interspace / 2)
        }
    }
    /// 上部动画的持续时间
    @objc public var topVAnimationDuration:Double = 0.5
    /// 下部动画的持续时间
    @objc public var bottomVAnimationDuration:Double = 0.25
    
    /// 上半部显示
    weak var topV:PPFHalfCharView!
    /// 下半部显示
    weak var bottomV:PPFHalfCharView!
    
    var topVConstraint:NSLayoutConstraint!
    var bottomVConstraint:NSLayoutConstraint!
    
    public init(frame: CGRect,char:Character) {
        self.char = char
        super.init(frame: frame)
        initializeUIs()
        initializeConstraints()
    }

    @objc public init(frame: CGRect,char:String) {
        guard char.count == 1 else{
            fatalError("char must be one charactor")
        }
        self.char = Character(char)
        super.init(frame: frame)
        initializeUIs()
        initializeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUIs() {
        backgroundColor = UIColor.clear
        clipsToBounds = false
        topV = {
            let v = PPFHalfCharView(position: .down, offset: CGPoint(x: 0, y: interspace / 2))
            v.translatesAutoresizingMaskIntoConstraints = false
            v.charLabel.backgroundColor = .black
            v.charLabel.textColor = .white
            v.setChar(char)
            self.addSubview(v)
            return v
        }()
        bottomV = {
            let v = PPFHalfCharView(position: .up, offset: CGPoint(x: 0, y: interspace / 2))
            v.translatesAutoresizingMaskIntoConstraints = false
            v.charLabel.backgroundColor = .black
            v.charLabel.textColor = .white
            v.setChar(char)
            self.addSubview(v)
            return v
        }()
    }
    private func initializeConstraints() {
        topV.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topV.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topV.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topVConstraint = topV.bottomAnchor.constraint(equalTo: centerYAnchor,constant: interspace / -2)
        topVConstraint.isActive = true
        
        bottomVConstraint = bottomV.topAnchor.constraint(equalTo: centerYAnchor,constant: interspace / 2)
        bottomVConstraint.isActive = true
        bottomV.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomV.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomV.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    

    /// 动画,上部到中部
    private func animateTopToMiddle(char:Character,completionHandle: (()->())?) {
        let height = (bounds.height - interspace) / 2 // haflCharView的高度
        
        let v:PPFHalfCharView = {
            let v = PPFHalfCharView(position: .down, offset: CGPoint(x: 0, y: interspace / 2))
            v.frame = CGRect(x: 0, y: 0, width: bounds.width, height: height)
            
            v.charLabel.font = topCharFont
            v.charLabel.textColor = topCharColor
            v.charLabel.backgroundColor = topCharBackgroundColor
            
            v.setChar(char)
            addSubview(v)
            return v
        }()
        
        topV.setChar(self.char)

        let y = bounds.height / 2 / height
        self.updateAnchorPoint(CGPoint(x: 0.5, y: y), view1: v)

        var tran = CATransform3DIdentity
        tran.m34 = m34
        tran = CATransform3DRotate(tran, CGFloat(-Double.pi) / 2, 1, 0, 0)

        UIView.animate(withDuration: topVAnimationDuration, delay: 0, options: .curveEaseIn, animations: {
            v.layer.transform = tran
        }) { (_) in
            v.removeFromSuperview()
            completionHandle?()
        }
    }
    
    /// 动画,从中部到底部
    private func animateMiddleToBottom(char:Character,completionHandle: (()->())?){
        let height = (bounds.height - interspace) / 2
        
        let v:PPFHalfCharView = {
            let v = PPFHalfCharView(position: .up, offset: CGPoint(x: 0, y: interspace / 2))
            
            let y0 = bounds.midY + interspace / 2
            v.frame = CGRect(x: 0, y: y0, width: bounds.width, height: height)
            
            v.charLabel.backgroundColor = bottomCharBackground
            v.charLabel.font = bottomCharFont
            v.charLabel.textColor = bottomCharColor
            v.setChar(char)
            
            let y = -interspace / height / 2
            self.updateAnchorPoint(CGPoint(x: 0.5, y: y), view1: v)
            
            var tran = CATransform3DIdentity
            tran.m34 = m34
            tran = CATransform3DRotate(tran, CGFloat(Double.pi) / 2, 1, 0, 0)
            v.layer.transform = tran
            
            addSubview(v)
            return v
        }()
        
        var tr = CATransform3DIdentity
        tr.m34 = m34
        UIView.animate(withDuration: bottomVAnimationDuration, delay: 0, options: .curveEaseOut, animations: {
            v.layer.transform = tr
        }) { (_) in
            v.removeFromSuperview()
            completionHandle?()
        }
    }
    
    private func updateAnchorPoint(_ point:CGPoint,view1:UIView){
        let x = view1.frame.origin.x + view1.bounds.width * point.x
        let y = view1.frame.origin.y + view1.bounds.height * point.y
        view1.layer.position = CGPoint(x: x, y: y)
        view1.layer.anchorPoint = point
    }
}

extension PPFFlipCharView {
    /// 改变字符
    ///
    /// - Parameters:
    ///   - fromChar: 开始字符
    ///   - toChar: 目标字符
    ///   - force: 如果开始字符和目标字符一样,是否也变换
    ///   - animation: 是否动画
    public func change(fromChar:Character,toChar:Character,force:Bool,animation:Bool) {
        guard force || fromChar != toChar else{
            return
        }
        self.char = toChar
        if animation {
            animateTopToMiddle(char: fromChar) {[weak self] in
                self?.animateMiddleToBottom(char: toChar, completionHandle: {
                    self?.bottomV.setChar(toChar)
                })
            }
        }else{
            topV.setChar(toChar)
            bottomV.setChar(toChar)
        }
    }
    
    /// 改变字符
    public func convertToChar(_ toChar:Character,force:Bool,animation:Bool = true){
        change(fromChar: char, toChar: toChar,force: force, animation: animation)
    }
    
    /// 改变字符
    @objc public func change(fromChar:String,toChar:String,force:Bool,animation:Bool) {
        guard fromChar.count == 1 && toChar.count == 1 else {
            fatalError("fromChar and toChar must be one Charactor")
        }
        change(fromChar: Character(fromChar), toChar: Character(toChar),force: force, animation: animation)
    }
    /// 改变字符
    @objc public func convertToChar(_ toChar:String,force:Bool,animation:Bool = true){
        guard toChar.count == 1 else {
            fatalError("toChar must be one Charactor")
        }
        change(fromChar: char, toChar: Character(toChar),force: force, animation: animation)
    }
}

