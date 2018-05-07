//
//  JuCountDown.h
//  JuCountDown
//
//  Created by Juvid on 2018/3/23.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
//打印信息设置
typedef void(^juHandleWithData)(id result);//下步操作后有跟新数据
@interface JuCountDown : NSObject{
    dispatch_source_t _timer;
    NSTimeInterval sh_timeInterval;
}
@property (nonatomic,copy  ) juHandleWithData sh_handleTime;//返回时间

-(void)juSetEndDate:(NSDate *)endData handle:(juHandleWithData)timeStr;

-(void)shDealloc;

@end
