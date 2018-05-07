//
//  JuGCD.m
//  testThread
//
//  Created by Juvid on 2018/3/1.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuGCD.h"

@implementation JuGCD
-(void)shGlobalQueue{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"11111 %@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"22222 %@",[NSThread currentThread]);
    });
}
-(void)shGroupQueue{
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        for (int i=0; i<10; i++) {
            NSLog(@"dispatch-1");
        }
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        for (int i=0; i<10; i++) {
            NSLog(@"dispatch-2");
        }
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"end");
    });

}

-(void)shSingQueue{
     dispatch_queue_t logInQueue=dispatch_queue_create("queue.login", DISPATCH_QUEUE_SERIAL);///< 串行队列

    dispatch_async(logInQueue, ^{
        NSLog(@"33333 %@",[NSThread currentThread]);
    });
    dispatch_async(logInQueue, ^{
        NSLog(@"44444 %@",[NSThread currentThread]);
    });
}
-(void)shMoreQueue{
    dispatch_queue_t logInQueue=dispatch_queue_create("queue.more111", DISPATCH_QUEUE_CONCURRENT);///< 并行

    dispatch_async(logInQueue, ^{
        NSLog(@"666666 %@",[NSThread currentThread]);
    });
    dispatch_async(logInQueue, ^{
        NSLog(@"555555 %@",[NSThread currentThread]);
    });
}
@end
