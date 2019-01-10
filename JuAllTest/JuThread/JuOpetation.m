//
//  JuOpetation.m
//  testThread
//
//  Created by Juvid on 2018/3/1.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuOpetation.h"

@implementation JuOpetation
-(void)juOperation{
    NSInvocationOperation *operarion=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(juStatrt:) object:nil];
    [operarion start];
    [self juOperationQueue];
    [self juBlockQueue];
}
-(void)juStatrt:(id)sender{
    NSLog(@"线程1 %@",[NSThread currentThread]);
}
-(void)juOperationQueue{
    
    NSInvocationOperation *operarion1=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(juQueue:) object:nil];
    NSInvocationOperation *operarion2=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(juQueue2:) object:nil];
    [operarion2 addDependency:operarion1];

    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [queue addOperation:operarion2];
    [queue addOperation:operarion1];

    [queue addOperationWithBlock:^{
        
    }];
    
//    [queue cancelAllOperations];
}
-(void)juBlockQueue{
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 2.添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"5---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"6---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"7---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"8---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.调用 start 方法开始执行操作
    [op start];

}
-(void)juQueue:(id)sender{
    NSLog(@"线程2 %@",[NSThread currentThread]);
}
-(void)juQueue2:(id)sender{

    NSLog(@"线程3 %@",[NSThread currentThread]);
}
@end
