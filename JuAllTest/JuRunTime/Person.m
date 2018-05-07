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

/*
 动态特性：方法解析和消息转发

 没有方法的实现，程序会在运行时挂掉并抛出 unrecognized selector sent to … 的异常。但在异常抛出前，Objective-C 的运行时会给你三次拯救程序的机会：

 Method resolution
 Fast forwarding
 Normal forwarding
 */
//如果需要传参直接在参数列表后面添加就好了

//1、动态方法解析: Method Resolution
void dynamicAdditionMethodIMP(id self, SEL _cmd, id name) {
    NSLog(@"dynamicAdditionMethodIMP");
}
//实例方法
+ (BOOL)resolveInstanceMethod:(SEL)name {
    NSLog(@"resolveInstanceMethod: %@", NSStringFromSelector(name));
    if (name == @selector(addObject:)) {
        class_addMethod([self class], name, (IMP)dynamicAdditionMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:name];
}
//类方法
+ (BOOL)resolveClassMethod:(SEL)name {
    NSLog(@"resolveClassMethod %@", NSStringFromSelector(name));
    return [super resolveClassMethod:name];
}

//2 快速转发: Fast Rorwarding
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(appendString:)) {
        return [NSMutableString string];
    }
    return nil;
}



//3 消息转发: Normal Forwarding
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{

    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return methodSignature;

//    NSString *method = NSStringFromSelector(aSelector);
//    if ([@"hasPrefix:" isEqualToString:method]) {
//        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
//        return signature;
//    }
//    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    SEL sel = @selector(travel:);
//    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
//    anInvocation = [NSInvocation invocationWithMethodSignature:signature];
//    [anInvocation setTarget:self];
//    [anInvocation setSelector:@selector(travel:)];
//    NSString *city = @"北京";
//    // 消息的第一个参数是self，第二个参数是选择子，所以"北京"是第三个参数
//    [anInvocation setArgument:&city atIndex:2];
//    if ([self respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:self];
//    } else {
//        [super forwardInvocation:anInvocation];
//    }
    // 从继承树中查找
//
//或者
    SEL sel = anInvocation.selector;
    if([self respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self];
    } else {
        [self doesNotRecognizeSelector:sel];
    }

}




// 完整的消息转发
- (void)travel:(NSString*)city{
    NSLog(@"Teacher travel：%@", city);
}
- (void)sendMessage:(NSString *)word
{
    NSLog(@"fast forwarding way : send message = %@", word);
}
-(void)juTest{
    NSLog(@"测试方法");
}
@end
