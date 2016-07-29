//
//  MERUICreator.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/13.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MERUICreator : NSObject

+ (UILabel*)createLabel:(NSString*) content color:(UIColor*) color font:(UIFont*) font;

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action;
+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action
                                   use2X:(BOOL)use2X;
+ (UIButton*)createButtonWithTitle:(NSString*)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont*)font
                            target:(id)target
                            action:(SEL)action;
@end
