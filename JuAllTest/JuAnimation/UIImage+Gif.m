//
//  UIImage+Gif.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/11.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "UIImage+Gif.h"

@implementation UIImage (Gif)
+(UIImage *)juGetGifWithName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData  *data = [NSData dataWithContentsOfFile:path];
    return [self juGetGifWithData:data];
}
+(UIImage *)juGetGifWithData:(NSData *)data{
    if (!data) {
        return nil;
    }
    UIImage *gifImage;
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    if (count<=1) {
        gifImage = [[UIImage alloc]initWithData:data];
    }else{
        NSMutableArray *gifImages = [NSMutableArray array];
        for (size_t i=0; i<count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            //获取图片信息
//            NSDictionary * info = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
//            NSDictionary * timeDic = [info objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
//            CGFloat time = [[timeDic objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime]floatValue];
            [gifImages addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
         gifImage = [UIImage animatedImageWithImages:gifImages duration:0.1*count];
    }
    CFRelease(source);
    return gifImage;
}


@end
