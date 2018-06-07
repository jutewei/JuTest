//
//  JuCornerView.m
//  JuAllTest
//
//  Created by Juvid on 2018/6/4.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuCornerView.h"

@implementation JuCornerView
-(instancetype)init{
    self=[super init];
    if (self) {
        self.tag=1111;
        //      //把 view2 的 左下角 和 右下角的直角切成圆角
//        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10,10,80,80)];
//        view2.backgroundColor = [UIColor blueColor];
//        [self addSubview:view2];
//
//        //得到view的遮罩路径
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(40,40)];
//        //创建 layer
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = view2.bounds;
//        //赋值
//        maskLayer.path = maskPath.CGPath;
//        view2.layer.mask = maskLayer;
//        [self juTest];
    }
    return self;
}

-(void)juTest{
    NSLog(@"哈哈哈哈");
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(20,20)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
//
//    maskLayer.lineWidth = 2.f;
//    maskLayer.strokeColor = [UIColor blackColor].CGColor;
//    maskLayer.fillColor = [UIColor clearColor].CGColor;
//
//
//    self.layer.mask = maskLayer;

//    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
//    borderLayer.frame = self.bounds;
//    //赋值
//    borderLayer.path = maskPath.CGPath;
//
////    CAShapeLayer *maskLayer = [CAShapeLayer layer];
////    maskLayer.frame = CGRectMake(0, 0, cellWidth, cellHeight);
////
////    CAShapeLayer *borderLayer = [CAShapeLayer layer];
////    borderLayer.frame = CGRectMake(0, 0, cellWidth, cellHeight);
//    borderLayer.lineWidth = 2.f;
//    borderLayer.strokeColor = [UIColor blackColor].CGColor;
//    borderLayer.fillColor = [UIColor clearColor].CGColor;
//    [self.layer insertSublayer:borderLayer atIndex:0];
//
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, cellWidth, cellHeight) cornerRadius:cornerRadius];
//    maskLayer.path = bezierPath.CGPath;
//    borderLayer.path = bezierPath.CGPath;
//
//    [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
//    [cell.layer setMask:maskLayer];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
