//
//  LayerAnimationView.m
//  wallpaper-elf
//
//  Created by mervin on 2016/11/4.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "LayerAnimationView.h"

@implementation LayerAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[UIColor clearColor] setFill];
    UIRectFill(rect);
    NSInteger pulsingCount = 3;
    double animationDuration = 3;
    CALayer * animationLayer = [CALayer layer];
    for (int i = 0; i < pulsingCount; i++) {
        CALayer * pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.backgroundColor = ColorWithAlpha(255, 216, 87, 0.5).CGColor;
        pulsingLayer.borderColor = ColorWithAlpha(255, 216, 87, 0.5).CGColor;
        pulsingLayer.borderWidth = 1;
        pulsingLayer.cornerRadius = rect.size.height / 2;
        
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = HUGE;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1;
        scaleAnimation.toValue = @1.423;
        
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        
        CAKeyframeAnimation *colorAnimation = [CAKeyframeAnimation animation];
        colorAnimation.keyPath = @"backgroundColor";
//        colorAnimation.keyPath = @"borderColor";
        colorAnimation.values = @[(__bridge id)ColorWithAlpha(255, 216, 87, 0.5).CGColor,
                                  (__bridge id)ColorWithAlpha(255, 231, 152, 0.5).CGColor,
                                  (__bridge id)ColorWithAlpha(255, 241, 197, 0.5).CGColor,
                                  (__bridge id)ColorWithAlpha(255, 241, 197, 0).CGColor];
        colorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
        
        CAKeyframeAnimation *colorAnimation1 = [CAKeyframeAnimation animation];
//        colorAnimation.keyPath = @"backgroundColor";
        colorAnimation1.keyPath = @"borderColor";
        colorAnimation1.values = @[(__bridge id)ColorWithAlpha(255, 216, 87, 0.5).CGColor,
                                  (__bridge id)ColorWithAlpha(255, 231, 152, 0.5).CGColor,
                                  (__bridge id)ColorWithAlpha(255, 241, 197, 0.5).CGColor,
                                  (__bridge id)ColorWithAlpha(255, 241, 197, 0).CGColor];
        colorAnimation1.keyTimes = @[@0.3,@0.6,@0.9,@1];
        
        animationGroup.animations = @[scaleAnimation, colorAnimation, colorAnimation1];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
        [animationLayer addSublayer:pulsingLayer];
    }
    [self.layer addSublayer:animationLayer];
}

@end
