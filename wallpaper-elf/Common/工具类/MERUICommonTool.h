//
//  MERUICommonTool.h
//  wallpaper-elf
//
//  Created by mervin on 16/8/4.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MERUICommonTool : NSObject

+ (CGFloat)getTextHeight:(NSLineBreakMode)lineBreakMode
                  byFont:(UIFont *)font
                    text:(NSString *)text
       constrainedToSize:(CGSize)constrainedSize;

@end
