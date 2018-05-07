//
//  JuGCD.h
//  testThread
//
//  Created by Juvid on 2018/3/1.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JuGCD : NSObject
-(void)shGlobalQueue;
-(void)shGroupQueue;
-(void)shSingQueue;
-(void)shMoreQueue;
///循环调用
-(void)juDisApply;
-(void)juDisSpecific;
//栅栏 当在并发队列里面使用栅栏时候，栅栏之前的并发任务开始并发执行，执行完毕后，执行栅栏内的任务，等栅栏任务执行完毕后，再并发执行栅栏后的任务。
-(void)juBarrier;
@end
