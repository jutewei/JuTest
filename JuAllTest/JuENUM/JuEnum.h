//
//  JuEnum.h
//  JuAllTest
//
//  Created by Juvid on 2018/5/8.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>

enum JuCEnumType{
    JuCEnumTypeNone,
    JuCEnumTypeFirst,
};
//enum JuCEnumType JuCEnumType;
///位移操作枚举定义
typedef NS_ENUM(NSInteger,JuEnumType) {
    JuEnumTypeNone,
    JuEnumTypeFirst,
};
//相当于 enum JuEnumType JuEnumType;
struct student{
    char name[20];      //姓名
    int sex;            //性别
    int age;            //年龄
};
//stu1，stu2 相当于 struct student stu1
typedef struct Student{
    char name[20];     //名字
    int age;            //年龄
    int sex;            //性别
} JuStudent;
//JuStudent 相当于 struct Student

@interface JuEnum : NSObject

-(void)juStartEnum;
@end
