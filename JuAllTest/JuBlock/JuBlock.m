//
//  JuBlock.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBlock.h"
typedef double (^SpeedFunction)(double);
@implementation JuBlock
-(void)completeBlock{
    double (^distanceFromRateAndTime)(double rate,double time);

    distanceFromRateAndTime = ^double(double rate, double time)
    {
        return rate *time;
    };
    // Call the block
    double dx=distanceFromRateAndTime(35,1.5);

}

- (void)driveForDuration:(double)duration
       withVariableSpeed:(double (^)(double time))speedFunction
                   steps:(int)numSteps{

}

- (void)driveForDuration1:(double)duration
        withVariableSpeed:(SpeedFunction)speedFunction
                    steps:(int)numSteps{

}
//不带参数的Block
-(void)noParaBlock{
    double(^randomPercent)(void)=^{
        return (double)arc4random()/4294967295;
    };
    NSLog(@"Gas tank is %.1f%% full",randomPercent() * 100);
}
//Block的闭包性(closure)
-(void)closureBlock{

    NSString *make=@"Honda";
    NSString *(^getFullCarName)(NSString *) =^(NSString *model){
        return [make stringByAppendingFormat:@" %@",model];
    };
    getFullCarName(@"测试");

}
@end
