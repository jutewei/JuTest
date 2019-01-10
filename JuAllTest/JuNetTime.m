//
//  JuNetTime.m
//  JuAllTest
//
//  Created by Juvid on 2018/7/12.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuNetTime.h"

@implementation JuNetTime
- (void)getInternetDate

{

    NSString *urlString = @"http://www.beijing-time.org/time.asp";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    //NSLog(@">>>>> response :%@",response);
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];

    //NSLog(@">>>>> date :%@",date);
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    //NSLog(@">>>>> date :%@",date);
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CHS"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: netDate];
    NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
    //NSLog(@">>>>> localeDate :%@",localeDate);
    NSString *tmpDate = [NSString stringWithFormat:@"%@",localeDate];
    tmpDate = [tmpDate stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
    //NSLog(@">>>>> localeDate :%@",tmpDate);

    NSDateFormatter *format1=[[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *nowDate = [format1 dateFromString:tmpDate];
    NSString *nowDate_ = [format1 stringFromDate:nowDate];
//    return nowDate_;




}

@end
