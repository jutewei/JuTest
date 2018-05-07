//
//  JuEncryption.h
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 RSA iOS客户端公钥加密私钥解密->
 iOS端公钥加密私钥解密、java端公钥加密私钥解密，java端私钥加密公钥解密都容易做到，iOS不能私钥加密公钥解密，只能用于验签）
 DES加密是对称的，网络抓包加上反编译可能会被破解（密钥加密和秘钥解密）；DES数据加密标准算法密钥长度较小(56位),
 AES 和DES类似 安全性高于DES；AES设计有三个密钥长 度:128,192,256位，相对而言，AES的128密钥比DES的56密钥强1021倍[2]；秘钥越长加密时间越长；
 MD5 为不可逆加密
 */
@interface JuEncryption : NSObject
+ (NSString *)setMD5:(NSString *)str;
@end
