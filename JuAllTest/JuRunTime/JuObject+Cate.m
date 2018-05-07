//
//  JuObject+Cate.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuObject+Cate.h"
#import <objc/runtime.h>
@implementation JuObject (Cate)

-(void)setSh_subLoda:(JuSubSubLoad *)sh_subLoda{
    objc_setAssociatedObject(self, @selector(sh_subLoda), sh_subLoda, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(JuSubSubLoad *)sh_subLoda{
    return objc_getAssociatedObject(self, @selector(sh_subLoda));
}
@end
