# PixiJS Divin
具体分析见..

## 使用
yarn start后, 即可引用bundles/pixi.js/dist里的文件

## 当前版本变更
当前版本对Graphics进行了深度定制, 使其支持了"线宽不依赖scaling"特性\
代价是: 覆盖了batch核心模块, 所以:
当前的状态是: 不支持 Text, 不支持Texture, 不支持Mesh (未同步batch修改)\

## 为何需要实现 lineWidth with scaling independant 特性?
原始pixi.js版本中, drawArrays有两种模式: Line_Strip模式, Triangle模式\
- Line_Strip模式对应到lineStyle.native = true, 同一Graphics内相同颜色的线会batch\
- Triangle模式对应到lineStyle.native = false, 相同颜色的线可跨Graphics Batch\
对于大多数线框型Graphics, 并没有背景, 此时如果设置为native=true, 将打断Batch, 画10000个矩形mac2015不到20fps\
此时如果改为native=false, 画10000个矩形轻松达到60fps\

然而改native=false后, 线宽会与scaling同步缩放, 这是无法接受的, 两种解决方案:\
- 在进入shader前, 利用scaling反向缩放线宽，逻辑简单, 但每次都要重算、重新三角化
- 使用shader根据scaling缩放
这里使用了第二种方案

