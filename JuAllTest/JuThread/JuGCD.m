//
//  JuGCD.m
//  testThread
//
//  Created by Juvid on 2018/3/1.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuGCD.h"

@implementation JuGCD
//线程单利
-(void)shGlobalQueue{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"11111 %@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"22222 %@",[NSThread currentThread]);
    });
}
//线程组
-(void)shGroupQueue{
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        for (int i=0; i<10; i++) {
            NSLog(@"dispatch-7");
        }
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        for (int i=0; i<10; i++) {
            NSLog(@"dispatch-8");
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
//
-(void)shMoreQueue{
    dispatch_queue_t logInQueue=dispatch_queue_create("queue.more111", DISPATCH_QUEUE_CONCURRENT);///< 并行

    dispatch_async(logInQueue, ^{
        NSLog(@"666666 %@",[NSThread currentThread]);
    });
    dispatch_async(logInQueue, ^{
        NSLog(@"555555 %@",[NSThread currentThread]);
    });
}
//循环调用
-(void)juDisApply{
    dispatch_apply(3, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(size_t i) {
        NSURL *url;
        switch (i) {
            case 0:
                url = [NSURL URLWithString:@"https://mp.weixin.qq.com/s/yqIWotYZv6boQ98vIw65lA"];
                break;
            default:
                break;
        }

    });
}
-(void)juDisSpecific{
    static  void *queueKey1 = "queueKey1";
    dispatch_queue_t queue1 = dispatch_queue_create(queueKey1, DISPATCH_QUEUE_SERIAL);
    dispatch_queue_set_specific(queue1, queueKey1, &queueKey1, NULL);
    dispatch_sync(queue1, ^{
        if (dispatch_get_specific(queueKey1)) {
            //当前队列是queue1队列，所以能取到queueKey1对应的值，故而执行
        }else{
        }
    });
}
//栅栏 当在并发队列里面使用栅栏时候，栅栏之前的并发任务开始并发执行，执行完毕后，执行栅栏内的任务，等栅栏任务执行完毕后，再并发执行栅栏后的任务。
-(void)juBarrier{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-1");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-2");
    });
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-3");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-4");
    });
}
@end
