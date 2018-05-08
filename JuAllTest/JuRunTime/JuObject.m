//
//  MyTestObject.m
//  JuCountDown
//
//  Created by Juvid on 2018/3/26.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuObject.h"
#import "NoneClass.h"
#import "JuPerson.h"
#import "JuSubSubLoad.h"
#import "JuSubLoad.h"

@implementation JuObject

-(instancetype)init{
    self =[super init];
    if (self) {
        id p = [[JuPerson alloc] init];
        [p appendString:@"哈哈哈哈"];
        [p addObject:@"呵呵呵呵"];
        [p hasPrefix:@"ju"];
        [p juTest];


    }
    return self;
}
-(void)juStart{
    id object = [[[self class] alloc]init];
    JuSubLoad *load =[[JuSubLoad alloc]init];
    JuSubSubLoad *load1 =[[JuSubSubLoad alloc]init];
}
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
