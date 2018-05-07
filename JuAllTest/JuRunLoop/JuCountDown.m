//
//  JuCountDown.m
//  JuCountDown
//
//  Created by Juvid on 2018/3/23.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuCountDown.h"

@implementation JuCountDown

-(void)juSetEndDate:(NSDate *)endData handle:(juHandleWithData)timeStr{

    NSDate *startDate = [NSDate date];
    sh_timeInterval =[endData timeIntervalSinceDate:startDate];
    if (_timer==nil) {
        if (sh_timeInterval!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(sh_timeInterval<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        timeStr([NSString stringWithFormat:@"00:00:00"]);
                    });
                }else{
                    int days = (int)(sh_timeInterval/(3600*24));
                    if (days==0) {

                    }
                    int hours = (int)((sh_timeInterval-days*24*3600)/3600);
                    int minute = (int)(sh_timeInterval-days*24*3600-hours*3600)/60;
                    int second = sh_timeInterval-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {

                        }else{

                        }
                        NSString *strHours,*strMinute,*strSecond;
                        if (hours<10) {
                            strHours = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                            strHours = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            strMinute = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            strMinute = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            strSecond = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            strSecond = [NSString stringWithFormat:@"%d",second];
                        }
                        timeStr([NSString stringWithFormat:@"%@:%@:%@",strHours,strMinute,strSecond]);

                    });
                    sh_timeInterval--;
                }
            });
            dispatch_resume(_timer);
        }
    }

}

-(void)shDealloc{
    dispatch_source_cancel(_timer);
    _timer = nil;
}

-(void)dealloc{
    NSLog(@"释放了");
}
@end
