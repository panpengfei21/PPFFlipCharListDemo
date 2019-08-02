# PPFFlipStringView

## 效果
![翻牌字符串](https://upload-images.jianshu.io/upload_images/2261768-0ca20dc95ecbc1c0.gif?imageMogr2/auto-orient/strip)


## 引用

```
pod 'PPFFlipStringView', '~> 0.0.1'
```

## 怎么用
```
let v = PPFFlipStringView(frame: CGRect(x: 50, y: 50, width: 300, height: 60), number: numberOfChars, charSpace: 4, direction: .horizontal)
// 设置字体
v.setTextFont(UIFont.systemFont(ofSize: 60))
// 设置字的颜色
v.setTextColor(UIColor.white)
// 设置字的背景颜色
v.setTextBackgroundColor(UIColor.brown)
// 设置字符里面空隙的距离
v.setSpaceInsideChar(2)
            
view.addSubview(v)

/// 变换字符串
v.setText("Abde3", force: false)
``` 
