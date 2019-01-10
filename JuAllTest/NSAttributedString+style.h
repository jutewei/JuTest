//
//  NSAttributedString+style.h
//  PFBPublic
//
//  Created by Juvid on 2018/5/23.
//  Copyright © 2018年 Juvid. All rights reserved.
//
/*
 *
 NSStringDrawingTruncatesLastVisibleLine：

 如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。

 NSStringDrawingUsesLineFragmentOrigin：

 绘制文本时使用 line fragement origin 而不是 baseline origin。

 The origin specified when drawing the string is the line fragment origin and not the baseline origin.

 NSStringDrawingUsesFontLeading：

 计算行高时使用行距。（译者注：字体大小+行间距=行距）

 NSStringDrawingUsesDeviceMetrics：

 计算布局时使用图元字形（而不是印刷字体）。

 Use the image glyph bounds (instead of the typographic bounds) when computing layout.
 */
#import <UIKit/UIKit.h>

@interface NSAttributedString (style)

/**
 获取文本的高度(无行距)

 @param string 文本
 @param width 最大宽度
 @param font 字体
 @return 高度
 */
+(CGFloat)juGetSringHeigth:(NSString *)string width:(float)width font:(CGFloat)font;


/**
 获取文本的宽度(无行距)

 @param string 文本
 @param height 最大高度
 @param font 字体
 @return 宽度
 */
+(CGFloat)juGetStringWidth:(NSString *)string height:(float)height font:(CGFloat)font;

/**
 获取文本宽高

 @param string 文本
 @param width 最大宽
 @param font 字体
 @param space 行距
 @return 宽高
 */
+(CGSize )juGetAttributeSize:(NSString *)string Width:(float)width font:(CGFloat)font lineSpace:(NSInteger)space;

/**
 设置行距

 @param lineSpace 行距
 @return 字典
 */
+(NSDictionary *)juLineSpace:(CGFloat)lineSpace;

+(NSMutableParagraphStyle *)juParagraphLineSpace:(CGFloat)lineSpace;

@end

@interface NSMutableAttributedString (style)

/*===============================================================*/

/**
 获取富文本

 @param string 文本
 @return 富文本
 */
+(NSMutableAttributedString *)juGetWithString:(NSString *)string;

+(NSMutableAttributedString *)juGetSpaceString:(NSString *)string;

+(NSMutableAttributedString *)juGetWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;

/**
 获取富文本

 @param string 文本
 @param lineSpace 行距
 @param graphSpace 段落
 @return 富文本
 */
+(NSMutableAttributedString *)juGetWithString:(NSString *)string lineSpace:(CGFloat)lineSpace paragraph:(CGFloat)graphSpace;

+(NSMutableAttributedString *)juGetWithString:(NSString *)string attributes:(NSDictionary *)atts;


/**
 设置指定文本颜色

 @param color 颜色
 @param string 文本
 */
-(void)juSetForegroundColor:(UIColor *)color rangStr:(NSString *)string;///< 特殊颜色

/**
 设置指定文本字体

 @param font 字体
 @param string 文本
 */

-(void)juSetForegroundFont:(UIFont *)font rangStr:(NSString *)string;
/**
 设置指定文本颜色字体

 @param color 颜色
 @param font 字体
 @param string 文本
 */
-(void)juSetForegroundColor:(UIColor *)color withFont:(UIFont *)font rangStr:(NSString *)string;

-(void)juParagraphSpace:(CGFloat)graphSpace withString:(NSString *)string;


/**
 设置指定文本中划线

 @param rangSring 文本
 */
-(void)juSetStrikethrough:(NSString *)rangSring;///< 中划线 下划线


/**
 设置价格的变态字体

 @param string 文本
 @param font 字体
 @return 富文本
 */
+(NSMutableAttributedString *)juSetPriceWithString:(NSString *)string withFont:(UIFont *)font;

-(void )juLink:(CGFloat)graphSpace withString:(NSString *)string;

@end
