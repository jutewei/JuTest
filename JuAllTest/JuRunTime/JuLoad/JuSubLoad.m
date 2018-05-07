//
//  JuSubLoad.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuSubLoad.h"

@implementation JuSubLoad

-(instancetype)init{
    self =[super init];
    if (self) {
    }
    return self;
}
+(void)load{
//    [super load]; 使用super再次调用父类load方法
    NSLog(@"JuSubLoad _cmd: %@", NSStringFromSelector(_cmd));
}
+ (void)initialize{
//    [super initialize]; 使用super或者不重写此方法会再调一次父类initialize方法
    NSLog(@"JuSubLoad _cmd: %@", NSStringFromSelector(_cmd));
}
@end
