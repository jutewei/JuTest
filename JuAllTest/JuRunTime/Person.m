//
//  Person.m
//  JuCountDown
//
//  Created by Juvid on 2018/3/26.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
@synthesize name = _name;
@synthesize age = _age;
//如果需要传参直接在参数列表后面添加就好了
void dynamicAdditionMethodIMP(id self, SEL _cmd, id name) {
    NSLog(@"dynamicAdditionMethodIMP");
}

+ (BOOL)resolveInstanceMethod:(SEL)name {
    NSLog(@"resolveInstanceMethod: %@", NSStringFromSelector(name));
    if (name == @selector(appendString:)) {
        class_addMethod([self class], name, (IMP)dynamicAdditionMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:name];
}

+ (BOOL)resolveClassMethod:(SEL)name {
    NSLog(@"resolveClassMethod %@", NSStringFromSelector(name));
    return [super resolveClassMethod:name];
}
// 完整的消息转发
- (void)travel:(NSString*)city
{
    NSLog(@"Teacher travel：%@", city);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *method = NSStringFromSelector(aSelector);
    if ([@"appendString:" isEqualToString:method]) {

        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return signature;
    }
    return nil;
}
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(appendString:)) {
        return [NSMutableString string];
    }
    return nil;
}
- (void)sendMessage:(NSString *)word
{
    NSLog(@"fast forwarding way : send message = %@", word);
}
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = @selector(travel:);
    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    anInvocation = [NSInvocation invocationWithMethodSignature:signature];
    [anInvocation setTarget:self];
    [anInvocation setSelector:@selector(travel:)];
    NSString *city = @"北京";
    // 消息的第一个参数是self，第二个参数是选择子，所以"北京"是第三个参数
    [anInvocation setArgument:&city atIndex:2];

    if ([self respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self];
        return;
    } else {

    }

    // 从继承树中查找
    [super forwardInvocation:anInvocation];
}

@end
