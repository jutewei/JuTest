//
//  JuLinkLabel.m
//  JuLinkLabel
//
//  Created by  Juvid on 9/29/16.
//  Copyright (c) 2015 Petr Juvid(zhutianwei). All rights reserved.
//

#import "JuLinkLabel.h"
#import <CoreText/CoreText.h>
//#import "SHUserShare.h"
//#import "PFBShareNewWebVC.h"
@interface JuLinkLabel ()<UIAlertViewDelegate>{
    NSArray *sh_Matches;///<
    BOOL isTouch;///< 正在选址
    BOOL isAddLink;///< 刚加了条件
}

@end

@implementation JuLinkLabel

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self shAddObserver];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self shAddObserver];
    }
    return self;
}
-(void)shAddObserver{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:@"attributedText" options:options context:nil];
    [self addObserver:self forKeyPath:@"text" options:options context:nil];
    self.userInteractionEnabled = YES;
    if (self.text.length) {
        [self highlightLinksWithIndex:NSNotFound isNoTouch:YES];
    }
}

-(void)shReMoveObserver{
    [self removeObserver:self forKeyPath:@"attributedText"];
    [self removeObserver:self forKeyPath:@"text"];

}
-(void)dealloc{
    [self shReMoveObserver];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //    id new= change[@"new"];
    //    id old= change[@"old"];
    // 遇到这些情况就直接返回
    //    if ([new isEqual:old]||isTouch) return;
    if (isTouch) {
        isTouch=NO;
        return;
    }
    if (isAddLink) {
        isAddLink=NO;
        return;
    }
    // 看不见
    if ([keyPath isEqualToString:@"attributedText"]||[keyPath isEqualToString:@"text"]) {
        [self highlightLinksWithIndex:NSNotFound isNoTouch:YES];
    }

}
- (BOOL)isIndex:(CFIndex)index inRange:(NSRange)range {
    return index > range.location && index < range.location+range.length;
}
- (void)highlightLinksWithIndex:(CFIndex)index isNoTouch:(BOOL)isNoTouch{
    isTouch =!isNoTouch;
    NSMutableAttributedString *attributedString ;
    if (self.attributedText) {
        attributedString =[self.attributedText mutableCopy] ;
    }else{
        attributedString=[[NSMutableAttributedString alloc]initWithString:self.text];
    }

    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber|NSTextCheckingTypeLink error:&error];
    sh_Matches = [detector matchesInString:attributedString.string options:0 range:NSMakeRange(0, attributedString.length)];
    if ([sh_Matches count]==0) {
        return;
    }
    for (NSTextCheckingResult *match in sh_Matches) {
        if ([match resultType] == NSTextCheckingTypeLink||[match resultType] == NSTextCheckingTypePhoneNumber) {
            NSRange matchRange = [match range];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:matchRange];
            if ([self isIndex:index inRange:matchRange]) {
                [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithWhite:0.9 alpha:1] range:matchRange];
            }
            else {
                [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:matchRange];
            }
//            if ([match resultType] == NSTextCheckingTypeLink) {
//                [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:matchRange];
//            }
        }
    }
    if(!isTouch) isAddLink=YES;
    self.attributedText=attributedString;

}


- (CFIndex)characterIndexAtPoint:(CGPoint)point {

    ////////

    NSMutableAttributedString *optimizedAttributedText = [self.attributedText mutableCopy];

    [self.attributedText enumerateAttribute:(NSString*)kCTParagraphStyleAttributeName inRange:NSMakeRange(0, [optimizedAttributedText length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {

        NSMutableParagraphStyle* paragraphStyle = [value mutableCopy];

        if ([paragraphStyle lineBreakMode] == kCTLineBreakByTruncatingTail) {
            [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        }

        [optimizedAttributedText removeAttribute:(NSString*)kCTParagraphStyleAttributeName range:range];
        if (paragraphStyle) {
            [optimizedAttributedText addAttribute:(NSString*)kCTParagraphStyleAttributeName value:paragraphStyle range:range];
        }
    }];

    ////////

    if (!CGRectContainsPoint(self.bounds, point)) {
        return NSNotFound;
    }

    CGRect textRect = [self shTextRect];

    if (!CGRectContainsPoint(textRect, point)) {
        return NSNotFound;
    }

    // Offset tap coordinates by textRect origin to make them relative to the origin of frame
    point = CGPointMake(point.x - textRect.origin.x, point.y - textRect.origin.y);
    // Convert tap coordinates (start at top left) to CT coordinates (start at bottom left)
    point = CGPointMake(point.x, textRect.size.height - point.y);

    //////
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)optimizedAttributedText);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, textRect);

    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [self.attributedText length]), path, NULL);

    if (frame == NULL) {
        CFRelease(path);
        return NSNotFound;
    }

    CFArrayRef lines = CTFrameGetLines(frame);

    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);

    //NSLog(@"num lines: %d", numberOfLines);

    if (numberOfLines == 0) {
        CFRelease(frame);
        CFRelease(path);
        return NSNotFound;
    }

    NSUInteger idx = NSNotFound;

    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);

    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {

        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);

        // Get bounding information of line
        CGFloat ascent, descent, leading, width;
        width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = floor(lineOrigin.y - descent);
        CGFloat yMax = ceil(lineOrigin.y + ascent);

        // Check if we've already passed the line
        if (point.y > yMax) {
            break;
        }

        // Check if the point is within this line vertically
        if (point.y >= yMin) {

            // Check if the point is within this line horizontally
            if (point.x >= lineOrigin.x && point.x <= lineOrigin.x + width) {

                // Convert CT coordinates to line-relative coordinates
                CGPoint relativePoint = CGPointMake(point.x - lineOrigin.x, point.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);

                break;
            }
        }
    }

    CFRelease(frame);
    CFRelease(path);

    return idx;
}

#pragma mark --

- (CGRect)shTextRect {

    CGRect textRect = [self textRectForBounds:self.bounds limitedToNumberOfLines:self.numberOfLines];
    textRect.origin.y = (self.bounds.size.height - textRect.size.height)/2;

    if (self.textAlignment == NSTextAlignmentCenter) {
        textRect.origin.x = (self.bounds.size.width - textRect.size.width)/2;
    }
    if (self.textAlignment == NSTextAlignmentRight) {
        textRect.origin.x = self.bounds.size.width - textRect.size.width;
    }

    return textRect;
}


#pragma mark --
-(void)juTouchEndPoint:(CGPoint )point{
    if (sh_Matches.count==0) return;
    CFIndex index = [self characterIndexAtPoint:point];
    [self highlightLinksWithIndex:NSNotFound isNoTouch:NO];
    for (NSTextCheckingResult *match in sh_Matches) {
        NSRange matchRange = [match range];
        if ([match resultType] == NSTextCheckingTypeLink) {
            if ([self isIndex:index inRange:matchRange]) {
//                PFBShareNewWebVC *vc=[[PFBShareNewWebVC alloc]init];
//                vc.sh_Url=[NSString stringWithFormat:@"%@",match.URL];
//                [Ju_Share.topViewcontrol.navigationController pushViewController:vc animated:YES];
                //                [[UIApplication sharedApplication] openURL:match.URL];
                break;
            }
        }else if([match resultType] == NSTextCheckingTypePhoneNumber){
            if ([self isIndex:index inRange:matchRange]) {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:match.phoneNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
                [alert show];
                break;
            }
        }
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (sh_Matches.count>0) {
        UITouch *touch = [touches anyObject];
        CFIndex index = [self characterIndexAtPoint:[touch locationInView:self]];
        [self highlightLinksWithIndex:index isNoTouch:NO];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (sh_Matches.count>0) {
        UITouch *touch = [touches anyObject];
        CFIndex index = [self characterIndexAtPoint:[touch locationInView:self]];
        [self highlightLinksWithIndex:index isNoTouch:NO];
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (sh_Matches.count>0) {
        UITouch *touch = [touches anyObject];
        [self juTouchEndPoint:[touch locationInView:self]];
        //        CFIndex index = [self characterIndexAtPoint:[touch locationInView:self]];

    }
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (sh_Matches.count>0) {
        [self highlightLinksWithIndex:NSNotFound isNoTouch:NO];
    }
    [super touchesCancelled:touches withEvent:event];
}

///< 拨打电脑
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:  [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",alertView.message]]];
    }
}

@end
