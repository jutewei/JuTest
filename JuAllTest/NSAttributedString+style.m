//
//  NSAttributedString+style.m
//  PFBPublic
//
//  Created by Juvid on 2018/5/23.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "NSAttributedString+style.h"

@implementation NSAttributedString (style)

/**无行距**/
+(CGFloat)juGetSringHeigth:(NSString *)string width:(float)width font:(CGFloat)font{
    return [self juGetAttributeSize:string Width:width font:font lineSpace:0].height;
}

/**无行距**/
+(CGFloat)juGetStringWidth:(NSString *)string height:(float)height font:(CGFloat)font{
    return [self juGetAttributeSize:string Width:height font:font lineSpace:0].width;
}

+(CGSize )juGetAttributeSize:(NSString *)string Width:(float)width font:(CGFloat)font lineSpace:(NSInteger)space{
    CGSize sizeFrame=CGSizeZero;
    if (string.length != 0) {
        NSMutableDictionary *dicAtt = [NSMutableDictionary dictionary];
        if (space>0) {
            [dicAtt addEntriesFromDictionary:[self juLineSpace:space]];
        }
        [dicAtt setValue:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
        sizeFrame = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dicAtt context:nil].size;
        return sizeFrame;
    }
    return sizeFrame;
}

+(NSDictionary *)juLineSpace:(CGFloat)lineSpace{
    return @{NSParagraphStyleAttributeName:[self juParagraphLineSpace:lineSpace]};
}

+(NSMutableParagraphStyle *)juParagraphLineSpace:(CGFloat)lineSpace{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode=NSLineBreakByTruncatingTail;
    return paragraphStyle;
}


/*+ (NSUInteger)juOccurenceOfString:(NSString *)oriStr indexParam:(NSString *)indexStr{
 NSUInteger cnt = 0, length = [oriStr length];
 NSRange range = NSMakeRange(0, length);
 while(range.location != NSNotFound)
 {
 range = [oriStr rangeOfString: indexStr options:0 range:range];
 if(range.location != NSNotFound)
 {
 range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
 cnt++;
 }
 }
 return cnt;
 }*/
@end


@implementation NSMutableAttributedString (style)

/*===============================================================*/
+(NSMutableAttributedString *)juGetWithString:(NSString *)string{
    return [self juGetWithString:string attributes:nil];
}
/**默认行距为5**/
+(NSMutableAttributedString *)juGetSpaceString:(NSString *)string{
    return  [self juGetWithString:string lineSpace:5];
}

+(NSMutableAttributedString *)juGetWithString:(NSString *)string lineSpace:(CGFloat)lineSpace{
    return [self juGetWithString:string attributes:[self juLineSpace:lineSpace]];
}

+(NSMutableAttributedString *)juGetWithString:(NSString *)string lineSpace:(CGFloat)lineSpace paragraph:(CGFloat)graphSpace{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.paragraphSpacing=graphSpace;
    paragraphStyle.lineBreakMode=NSLineBreakByTruncatingTail;
    return [self juGetWithString:string attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
}

+(NSMutableAttributedString *)juGetWithString:(NSString *)string attributes:(NSDictionary *)atts{
    if(!string) return nil;
    NSMutableAttributedString *atttributed=[[NSMutableAttributedString alloc]initWithString:string attributes:atts];
    return atttributed;
}

/************特殊颜色和字体**************/
-(void)juSetForegroundColor:(UIColor *)color rangStr:(NSString *)string{
    [self juSetForegroundColor:color withFont:nil rangStr:string];
}

-(void)juSetForegroundColor:(UIColor *)color withFont:(UIFont *)font rangStr:(NSString *)string{
    if (string) {
        NSRange range=[self.string rangeOfString:string];

        if (font)   [self addAttribute:NSFontAttributeName value:font range: range];

        if (color)  [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
}
-(void)juSetForegroundFont:(UIFont *)font rangStr:(NSString *)string{
    if (string.length) {
        [self juSetForegroundColor:nil withFont:font rangStr:string];
    }
}

-(void )juParagraphSpace:(CGFloat)graphSpace withString:(NSString *)string{
    if (string.length) {
        NSRange rang=[self.string rangeOfString:string];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.paragraphSpacing=graphSpace;
        if (rang.location==NSNotFound)  return;
        [self addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:rang];
    }

}
-(void )juLink:(CGFloat)graphSpace withString:(NSString *)string{
    if (string.length) {
        NSRange rang=[self.string rangeOfString:string];
        [self addAttributes:@{NSLinkAttributeName:string} range:[self.string rangeOfString:string]];
    }

}
+(NSMutableAttributedString *)juSetPriceWithString:(NSString *)string withFont:(UIFont *)font{
    if (string) {
        NSMutableAttributedString *attString=[[NSMutableAttributedString alloc]initWithString:string];

        NSRange range=[string rangeOfString:@"￥"];
        if (range.location!=NSNotFound) {
            [attString addAttribute:NSFontAttributeName value:font range: range];

        }
        range=[string rangeOfString:@"."];
        if (range.location!=NSNotFound) {
            [attString addAttribute:NSFontAttributeName value:font range: NSMakeRange(range.location, range.length+2)];
        }
        return attString;
    }
    return nil;
}
/*
 NSString *_test  =  @"首行缩进根据字体大小自动调整 间隔可自定根据需求随意改变。。。。。。。" ;
 NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
 paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
 paraStyle01.headIndent = 0.0f;//行首缩进
 //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
 CGFloat emptylen = self.contentLabel.font.pointSize * 2;
 paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
 paraStyle01.tailIndent = 0.0f;//行尾缩进
 paraStyle01.lineSpacing = 2.0f;//行间距

 NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:_test attributes:@{NSParagraphStyleAttributeName:paraStyle01}];

 self.contentLabel.attributedText = attrText;
 */
-(void)juSetStrikethrough:(NSString *)rangSring{
    if (rangSring) {
        NSRange rang=[self.string rangeOfString:rangSring];
        //        if (rang.location!=NSNotFound) {
        //        @{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle)}
        [self addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)}  range:rang];
        //        }
    }
}
@end
