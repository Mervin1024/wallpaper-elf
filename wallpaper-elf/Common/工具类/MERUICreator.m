//
//  MERUICreator.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/13.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "MERUICreator.h"
#import "MERBoolHelper.h"

@implementation MERUICreator

+ (UILabel*)createLabel:(NSString*) content color:(UIColor*) color font:(UIFont*) font{
    CGSize size = [content sizeWithAttributes:@{ NSFontAttributeName : font }];
    
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0,0,size.width,size.height)];
    lab.text = content;
    lab.textColor = color;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    
    return lab;
}

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action{
    BOOL use2X = !IPAD;
    
    return [self createButtonWithNormalImage:normalImageName
                            highlightedImage:highlightedImageName
                                      target:target
                                      action:action
                                       use2X:use2X];
}

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action
                                   use2X:(BOOL)use2X
{
    UIButton* btn = [[UIButton alloc] init];
    
    UIImage* normalImage = [UIImage imageNamed:normalImageName];
    UIImage* highlightedImage = [UIImage imageNamed:highlightedImageName];
    
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (use2X) {
        btn.frame = CGRectMake(0, 0, normalImage.size.width/2, normalImage.size.height/2);
    } else {
        btn.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    }
    
    return btn;
}

+ (UIButton*)createButtonWithTitle:(NSString*)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont*)font
                            target:(id)target
                            action:(SEL)action
{
    CGSize size = [title sizeWithAttributes:@{ NSFontAttributeName : font }];
    size.width += IPAD ? 10 : 5;
    size.height += IPAD ? 10 : 5;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; //创建圆角矩形button
    [button setFrame:CGRectMake(0, 0, size.width, size.height)]; //设置button的frame
    [button setTitle:title forState:UIControlStateNormal]; //设置button的标题
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.backgroundColor = [UIColor clearColor];
    
    if (font) {
        button.titleLabel.font = font;
    }
    return button;
}

@end
