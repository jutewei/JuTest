//
//  ViewController.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "ViewController.h"
#import "JuObject.h"
#import "JuThread.h"
#import "JuRunLoop.h"
@interface ViewController ()
@property (nonatomic,strong)JuRunLoop *ju_loop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    runTime消息转发

    [self juRunTimeMsg];
    [self juThread];
    [self juLoop];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)juLoop{
    _ju_loop =[[ JuRunLoop alloc]init];
}
-(void)juRunTimeMsg{
    JuObject *myTestObject=[[JuObject alloc]init];
    [myTestObject nonClassMethod:@"你好呀"];
}
-(void)juThread{
    JuGCD *gcd=[[JuGCD alloc]init];
    [gcd shGroupQueue];
    [gcd shGlobalQueue];
    [gcd shSingQueue];
    [gcd shMoreQueue];
    [gcd juDisApply];
    [gcd juDisSpecific];
    [gcd juBarrier];


    JuOpetation *opetation=[[JuOpetation alloc]init];
    [opetation juOperation];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_ju_loop juStarLoop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
