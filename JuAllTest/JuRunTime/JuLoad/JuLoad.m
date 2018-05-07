//
//  JuLoad.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuLoad.h"

@implementation JuLoad
+(void)load{
    NSLog(@"JuLoad _cmd: %@", NSStringFromSelector(_cmd));
}
+ (void)initialize{
    NSLog(@"JuLoad _cmd: %@", NSStringFromSelector(_cmd));
}
@end
