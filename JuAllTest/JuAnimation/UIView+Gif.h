//
//  UIView+Gif.h
//  JuAllTest
//
//  Created by Juvid on 2018/5/11.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gif)<CAAnimationDelegate>
-(void)juSetGifImage:(NSString *)imageName;
-(void)juSetGifImage:(NSString *)imageName repeatCount:(NSInteger)repeatCount;
@end
