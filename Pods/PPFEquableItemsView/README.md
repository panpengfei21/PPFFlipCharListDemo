# PPFEquableItemView

## 效果
![效果图](https://upload-images.jianshu.io/upload_images/2261768-3b5c9ff95dcd1c0f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 引入

```
  1.cocoapods
    pod 'PPFEquableItemsView', '~> 0.0.1'
  2.直接拷贝
    PPFEquableItemsView.swift
```

## 怎么用
```
import PPFEquableItemsView
```

```
let first = {
     let v = PPFEquableItemsView(frame: CGRect(x: 10, y: 50, width: 200, height: 100), direction: .horizontal, dataSource: self, itemsSpace: 2)
     v.backgroundColor = UIColor.red
     self.view.addSubview(v)
     return v
}()
first.reloadDataSources()
```
