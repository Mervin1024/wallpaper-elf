//
//  MERUITransform.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/29.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "MERUITransform.h"
#import "UIView+RectangularProperty.h"

@implementation MERUITransform

+ (void)view:(UIView *)view pointTransform:(CGPoint)point{
    CGPoint center = view.center;
    center.x += point.x;
    center.y += point.y;
    view.center = center;
}

+ (void)view:(UIView *)view addLengthToWidth:(CGFloat)x height:(CGFloat)y{
    CGRect frame = view.frame;
    frame.size.width += x;
    frame.size.height += y;
    view.frame = frame;
}

+ (void)view:(UIView *)view scaleTransform:(CGFloat)scale{
    [self view:view scaleTransform:scale withTransformAnchor:view.layer.anchorPoint];
}

+ (void)view:(UIView *)view scaleTransform:(CGFloat)scale withTransformAnchor:(CGPoint)anchor{
    [self view:view vectorTransform:CGPointMake(scale, scale) withTransformAnchor:anchor];
    
}

+ (void)view:(UIView *)view vectorTransform:(CGPoint)vector{
    [self view:view vectorTransform:vector withTransformAnchor:view.layer.anchorPoint];
}

+ (void)view:(UIView *)view vectorTransform:(CGPoint)vector withTransformAnchor:(CGPoint)anchor{
    CGRect frame = view.frame;
    frame.size.width *= vector.x;
    frame.size.height *= vector.y;
    frame.origin.x += view.width * anchor.x * (1 - vector.x);
    frame.origin.y += view.height * anchor.y * (1 - vector.y);
    view.frame = frame;
}

@end
