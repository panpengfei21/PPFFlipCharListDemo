//
//  ViewController.swift
//  PPFFlipCharListDemo
//
//  Created by 潘鹏飞 on 2019/8/2.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var fv0:PPFFlipStringView!

    let numberOfChars = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fv0 = {
            let v = PPFFlipStringView(frame: CGRect(x: 50, y: 50, width: 300, height: 60), number: numberOfChars, charSpace: 4, direction: .horizontal)
            
            v.setTextFont(UIFont.systemFont(ofSize: 60))
            v.setTextColor(UIColor.white)
            v.setTextBackgroundColor(UIColor.brown)
            v.setSpaceInsideChar(2)
            
            view.addSubview(v)
            return v
        }()

        let _:UIButton = {
            let b = UIButton(type: .contactAdd)
            b.addTarget(self, action: #selector(ViewController.tapForButton), for: .touchUpInside)
            b.center = view.center
            view.addSubview(b)
            return b
        }()
    }

    @objc func tapForButton() {
        var r = ""
        let b = arc4random_uniform(UInt32(numberOfChars))
        for _ in 0 ..< (numberOfChars - Int(b)) {
            let a = arc4random_uniform(10)
            r.append("\(a)")
        }
        fv0.setText(r, force: false)
    }

}

