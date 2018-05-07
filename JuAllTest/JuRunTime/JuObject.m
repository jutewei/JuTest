//
//  MyTestObject.m
//  JuCountDown
//
//  Created by Juvid on 2018/3/26.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuObject.h"
#import "NoneClass.h"

@implementation JuObject
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"MyTestObject _cmd: %@", NSStringFromSelector(_cmd));

//    NoneClass *none = [[NoneClass alloc] init];
//    if ([none respondsToSelector: aSelector]) {
        return [NoneClass new];
//    }

    return [super forwardingTargetForSelector: aSelector];
}
@end
