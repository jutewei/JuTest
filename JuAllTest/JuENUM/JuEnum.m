//
//  JuEnum.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/8.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuEnum.h"


@implementation JuEnum
-(void)juStartEnum{
    enum JuCEnumType JuCEnumType;
    char *buf="ABCDEFG";
//    char juCar="1";
//    char juSing='A';
    JuStudent juStu ={"qwertyuiopasdfghjkl",2,3};
    NSLog(@"结构体%s",juStu.name);
}
@end
