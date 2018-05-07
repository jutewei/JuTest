//
//  JuTimerLoop.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuTimerLoop.h"

@implementation JuTimerLoop
-(instancetype)init{
    self =[super init];
    if (self) {
        [self juTimeStart];
    }
    return self;
}
-(void)juTimeStart{
//    彻底释放time
//    [timer invalidate];
//    timer=nil;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer test");
    }];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];

}
-(void)dealloc{

}
@end
