//
//  MERUICommonTool.m
//  wallpaper-elf
//
//  Created by mervin on 16/8/4.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "MERUICommonTool.h"

@implementation MERUICommonTool

+ (CGFloat)getTextHeight:(NSLineBreakMode)lineBreakMode
                  byFont:(UIFont *)font
                    text:(NSString *)text
       constrainedToSize:(CGSize)constrainedSize
{
    NSDictionary *attributes = @{ NSFontAttributeName : font };
    CGRect frame = [text boundingRectWithSize:constrainedSize
                                      options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                   attributes:attributes
                                      context:nil];
    return CGRectGetHeight(frame);
}

@end
