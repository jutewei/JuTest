//
//  JuEncryption.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuEncryption.h"
#import <CommonCrypto/CommonDigest.h>
@implementation JuEncryption
+ (NSString *)setMD5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), r);
    NSString *strFileName=[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return strFileName;

    //    const char *cStr = [str UTF8String];
    //    unsigned char result[16];
    //    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    //    return [NSString stringWithFormat:
    //            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
    //            result[0], result[1], result[2], result[3],
    //            result[4], result[5], result[6], result[7],
    //            result[8], result[9], result[10], result[11],
    //            result[12], result[13], result[14], result[15]
    //            ];
}

@end
