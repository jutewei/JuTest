//
//  UIResponder+FirstResponder.m
//  JuAllTest
//
//  Created by Juvid on 2018/7/10.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "UIResponder+FirstResponder.h"
static __weak id currentFirstResponder;
@implementation UIResponder (FirstResponder)

+ (id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
