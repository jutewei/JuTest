//
//  JuOpetation.h
//  testThread
//
//  Created by Juvid on 2018/3/1.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 Opetation创建线程
 1）使用NSInvocationOperation创建直接start，属于同步线程
 2）把NSInvocationOperation创建的线程加入NSOperationQueue 中，此时变成异步线程
 3）添加线程依赖[self.firstOperation addDependency:self.secondOperation] 第一个线程等第二个线程执行完再执行
 */
@interface JuOpetation : NSObject
-(void)juOperation;
-(void)juOperationQueue;
@end
