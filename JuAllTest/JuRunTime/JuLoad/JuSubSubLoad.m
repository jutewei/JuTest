//
//  JuSubSubLoad.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuSubSubLoad.h"

@implementation JuSubSubLoad
+(void)load{
     [super load];
    NSLog(@"JuSubSubLoad _cmd: %@", NSStringFromSelector(_cmd));
}
+ (void)initialize{
    NSLog(@"JuSubSubLoad _cmd: %@", NSStringFromSelector(_cmd));
}
-(void)dealloc{
    NSLog(@"释放了");
}
@end
