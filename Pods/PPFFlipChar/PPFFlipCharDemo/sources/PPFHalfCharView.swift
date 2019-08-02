//
//  HalfCharView.swift
//  NumberDemo
//
//  Created by 潘鹏飞 on 2019/7/31.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit

enum HalfCharViewPosition {
    case up
    case down
}

class PPFHalfCharView: UIView {
    weak var charLabel:UILabel!
    
    let offset:CGPoint
    let position:HalfCharViewPosition
    
    private var labelUpOrDownConstraint:NSLayoutConstraint!
    
    init(position:HalfCharViewPosition,offset:CGPoint) {
        self.position = position
        self.offset = offset
        super.init(frame: CGRect.zero)
        clipsToBounds = true
        initializeUIs()
        initializeConstraints()
    }
    
    private func initializeUIs() {
        charLabel = {
            let l = UILabel(frame: bounds)
            l.translatesAutoresizingMaskIntoConstraints = false
            l.textAlignment = .center
            addSubview(l)
            return l
        }()
    }
    private func initializeConstraints() {
        charLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: offset.x).isActive = true
        charLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        charLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        switch position {
        case .up:
            labelUpOrDownConstraint = charLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: -offset.y)
            labelUpOrDownConstraint.isActive = true
            charLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        case .down:
            labelUpOrDownConstraint = charLabel.centerYAnchor.constraint(equalTo: bottomAnchor, constant: offset.y)
            labelUpOrDownConstraint.isActive = true
            charLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChar(_ char:Character) {
        charLabel.text = String(char)
    }
    func setLabelUpOrDownConstraint(constant:CGFloat){
        switch position {
        case .up:
            labelUpOrDownConstraint.constant = -constant
        case .down:
            labelUpOrDownConstraint.constant = constant
        }
    }
}
