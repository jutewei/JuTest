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
//    [queue cancelAllOperations];
}
-(void)juQueue:(id)sender{
    NSLog(@"线程2 %@",[NSThread currentThread]);
}
-(void)juQueue2:(id)sender{

    NSLog(@"线程3 %@",[NSThread currentThread]);
}
@end
