//
//  UIViewGif.swift
//  JuAllTest
//
//  Created by Juvid on 2018/5/11.
//  Copyright © 2018年 Juvid. All rights reserved.
//

import UIKit
typealias dataBlock = (Array<Any>,Array<NSNumber>,Float,CGSize) ->()

extension UIView:CAAnimationDelegate{
    
    func juSetGifImage(name : String)  {
        self.juSetGifImage(name: name, repeatCount: Int.max)
    }

    func juSetGifImage(name :String ,repeatCount : Int)  {
        weak var weakSelf  =  self
        self.getGifImages(name: name) { (imageArray, timeArray, totalTime, size) in
            if imageArray.count==0 {return}
            let animation = CAKeyframeAnimation.init(keyPath: "contents")
            animation.delegate = self
            var times = Array<NSNumber>.init()
            var currentTime : Float = 0
            for  i in 0...imageArray.count-1 {
                times.append( NSNumber.init(value: currentTime/totalTime))
                let time = timeArray[i].floatValue
                currentTime += time
            }
            animation.keyTimes = times
            animation.values = imageArray
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
            animation.repeatCount = Float(repeatCount)
            animation.duration = CFTimeInterval(totalTime)
            if repeatCount == 1{
                animation.isRemovedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
            }
            weakSelf?.juGetFrame(size: size, animation: animation)
        }


    }
    func getGifImages(name :String ,returnData:dataBlock)  {
        let path = Bundle.main.path(forResource: name, ofType: "gif")
        let data = NSData.init(contentsOfFile: path ?? "")
        if data != nil {
            let source = CGImageSourceCreateWithData(data!,nil);
            //获取gif文件中图片的个数
            let count = CGImageSourceGetCount(source!);
            //定义一个变量记录gif播放一轮的时间
            var allTime :Float = 0;
            //存放所有图片
            var  imageArray = Array<Any>()
            //存放每一帧播放的时间
            var timeArray = Array<NSNumber>()
            //存放每张图片的宽度 （一般在一个gif文件中，所有图片尺寸都会一样）
            var widths : CGFloat!
            var heighs : CGFloat!
            //遍历
            for i in 0...count-1 {
                let image : CGImage! = CGImageSourceCreateImageAtIndex(source!, i, nil);
                imageArray.append(image)
                //获取图片信息
                let info = CGImageSourceCopyPropertiesAtIndex(source!, i, nil) as NSDictionary?
                widths = (info![String(kCGImagePropertyPixelWidth)] as? CGFloat)!
                heighs = (info![String(kCGImagePropertyPixelHeight)] as? CGFloat)!
                let timeDic = info![String(kCGImagePropertyGIFDictionary)] as? NSDictionary;
                let time = timeDic![String(kCGImagePropertyGIFDelayTime)] as! NSNumber;
                allTime += time.floatValue;
                timeArray.append(time)
            }
            let size = CGSize.init(width: widths, height: heighs)

            returnData(imageArray,timeArray,allTime,size)
        }

    }


    func juGetFrame(size : CGSize , animation:CAKeyframeAnimation){
        var frame = self.bounds
        if self.contentMode != UIViewContentMode.scaleToFill {
            let width = size.width;
            let height = size.height;
            let vWidth = self.frame.width;
            let vHeight = self.frame.height;
            let scaleX = vWidth/width;
            let scaleY = vHeight/height;
            if scaleX>scaleY {
                let imgViewWidth = width*scaleY;
                frame = CGRect.init(x: vWidth/2-imgViewWidth/2, y: 0, width: imgViewWidth, height: vHeight)
            }else{
                let imgViewHeight = height*scaleX;
                frame = CGRect.init(x: 0, y: vHeight/2-imgViewHeight/2, width: vWidth, height: imgViewHeight)
            }
            let layer = CALayer.init()
            layer.frame = frame
            layer.add(animation, forKey: "gifAnimation")
            self.layer .addSublayer(layer)
        }
    }
}

extension UIImage{

}
