//
//  NoneClass.m
//  JuCountDown
//
//  Created by Juvid on 2018/3/26.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "NoneClass.h"
#import <objc/runtime.h>
@implementation NoneClass
+(void)load{
    NSLog(@"NoneClass1 _cmd: %@", NSStringFromSelector(_cmd));
}
+ (void)initialize{
    NSLog(@"NoneClass2 _cmd: %@", NSStringFromSelector(_cmd));
}
-(void) nonClassMethod:(NSString *)str
{
    NSLog(@"NoneClass3 _cmd: %@", NSStringFromSelector(_cmd));
}
@end
