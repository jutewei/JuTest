//
//  Person.h
//  JuCountDown
//
//  Created by Juvid on 2018/3/26.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JuPerson : NSObject
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSUInteger age;
-(void)juTest;
//- (void)appendString:(NSString *)word;
@end
