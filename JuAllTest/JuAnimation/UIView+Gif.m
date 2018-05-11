//
//  UIView+Gif.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/11.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "UIView+Gif.h"

@implementation UIView (Gif)
//解析gif文件数据的方法 block中会将解析的数据传递出来
-(void)getGifImageWithName:(NSString *)name returnData:(void(^)(NSArray<UIImage *> * imageArray, NSArray<NSNumber *>*timeArray,CGFloat totalTime, NSArray<NSNumber *>* widths,NSArray<NSNumber *>* heights))dataBlock{
    //通过文件的url来将gif文件读取为图片数据引用
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData  *data = [NSData dataWithContentsOfFile:path];
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    //获取gif文件中图片的个数
    size_t count = CGImageSourceGetCount(source);
    //定义一个变量记录gif播放一轮的时间
    float allTime=0;
    //存放所有图片
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    //存放每一帧播放的时间
    NSMutableArray * timeArray = [[NSMutableArray alloc]init];
    //存放每张图片的宽度 （一般在一个gif文件中，所有图片尺寸都会一样）
    NSMutableArray * widthArray = [[NSMutableArray alloc]init];
    //存放每张图片的高度
    NSMutableArray * heightArray = [[NSMutableArray alloc]init];
    //遍历
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        [imageArray addObject:(__bridge UIImage *)(image)];
        CGImageRelease(image);
        //获取图片信息
        CFDictionaryRef dicRef=CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        NSDictionary * info = (__bridge NSDictionary*)dicRef;
        CFRelease(dicRef);
        CGFloat width = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelWidth] floatValue];
        CGFloat height = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelHeight] floatValue];
        [widthArray addObject:[NSNumber numberWithFloat:width]];
        [heightArray addObject:[NSNumber numberWithFloat:height]];
        NSDictionary * timeDic = [info objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        CGFloat time = [[timeDic objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime]floatValue];
        allTime+=time;
        [timeArray addObject:[NSNumber numberWithFloat:time]];
    }
    CFRelease(source);
    dataBlock(imageArray,timeArray,allTime,widthArray,heightArray);

}

//为UIImageView添加一个设置gif图内容的方法：
-(void)juSetGifImage:(NSString *)imageName{
    [self juSetGifImage:imageName repeatCount:MAXFLOAT];
}
-(void)juSetGifImage:(NSString *)imageName repeatCount:(NSInteger)repeatCount{
    __weak typeof(self) weakSelf = self;
    [self getGifImageWithName:imageName returnData:^(NSArray<UIImage *> *imageArray, NSArray<NSNumber *> *timeArray, CGFloat totalTime, NSArray<NSNumber *> *widths, NSArray<NSNumber *> *heights) {
        if (imageArray.count==0) return ;
        @autoreleasepool {
            //添加帧动画
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
            animation.delegate=weakSelf;
            NSMutableArray * times = [[NSMutableArray alloc]init];
            float currentTime = 0;
            //设置每一帧的时间占比
            for (int i=0; i<imageArray.count; i++) {
                [times addObject:[NSNumber numberWithFloat:currentTime/totalTime]];
                currentTime+=[timeArray[i] floatValue];
            }
            [animation setKeyTimes:times];
            [animation setValues:imageArray];

            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            //设置循环
            animation.repeatCount= repeatCount;
//            [animation setBeginTime:CACurrentMediaTime()+1];
//              animation.fillMode = kCAFillModeBoth;
            //设置播放总时长
            animation.duration = totalTime;
            animation.removedOnCompletion = NO;
            if (repeatCount==1) {
                animation.fillMode = kCAFillModeForwards;
            }else{
                animation.fillMode = kCAFillModeBoth;
            }
            [weakSelf juGetFrame:CGSizeMake(widths.firstObject.floatValue, heights.firstObject.floatValue) withAinmation:animation];
        }
    }];
}

-(void)juGetFrame:(CGSize)size withAinmation:(CAKeyframeAnimation *)animation{

    CGRect frame;
    if (self.contentMode==UIViewContentModeScaleToFill) {
        frame=self.bounds;
    }
    else{
        CGFloat width = size.width;
        CGFloat height = size.height;
        CGFloat vWidth = CGRectGetWidth(self.frame);
        CGFloat vHeight = CGRectGetHeight(self.frame);
        float scaleX = vWidth/width;
        float scaleY = vHeight/height;
        if (scaleX>scaleY) {
            float imgViewWidth = width*scaleY;
            frame = (CGRect){vWidth/2-imgViewWidth/2,0,imgViewWidth,vHeight};
        }else{
            float imgViewHeight = height*scaleX;
            frame = (CGRect){0,vHeight/2-imgViewHeight/2,vWidth,imgViewHeight};
        }
    }
    CALayer *layer =[[CALayer alloc]init];
    layer.frame = frame;
    [layer addAnimation:animation forKey:@"gifAnimation"];
//    [layer removeAllAnimations];
    //Layer层添加
    [self.layer addSublayer:layer];
}

-(void)juDealloc{
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeAllAnimations];
        layer.contents=nil;
        [layer removeFromSuperlayer];
    }
}

@end
