//
//  JuButtonView.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/16.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuButtonView.h"

@implementation JuButtonView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    lab.hidden=YES;
    [self addSubview:lab];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
