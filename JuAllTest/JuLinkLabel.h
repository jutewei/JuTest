//
//  JuLinkLabel.h
//  JuLinkLabel
//
//  Created by  Juvid on 9/29/16.
//  Copyright (c) 2015 Juvid(zhutianwei). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuLinkLabel : UILabel

/**
 结束点击

 @param point 点击点
 */
-(void)juTouchEndPoint:(CGPoint )point;

/**
 开始点击

 @param point 点击位置
 */
//-(void)juTouchBeganPoint:(CGPoint )point;
@end
