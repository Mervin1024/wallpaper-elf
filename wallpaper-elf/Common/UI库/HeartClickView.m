//
//  HeartClickView.m
//  boxfish-english
//
//  Created by mervin on 16/7/14.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "HeartClickView.h"

@interface HeartClickView (){
    
}

@end

@implementation HeartClickView

- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, 54, 50)]) {
        UITapGestureRecognizer *clickedTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClicked)];
        [self addGestureRecognizer:clickedTap];
        [self setFilled:NO];
        [self setEnabled:YES];
    }
    return self;
}

#pragma mark - Setter
- (void)setEnabled:(BOOL)enabled{
    _enabled = enabled;
    self.userInteractionEnabled = enabled ? YES : NO;
}

- (void)setFilled:(BOOL)filled{
    _filled = filled;
    self.image = [UIImage imageNamed:filled? @"fullHeart" : @"notFullHeart"];
}

- (void)setFilled:(BOOL)filled animated:(BOOL)animated completion:(void(^)(void))completion{
    if (!animated) {
        [self setFilled:filled];
        return;
    }
    // 添加动画
    
}

#pragma mark - Action
- (void)didClicked{
    [self changeHeartStateWithAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(HeartClickView:afterClickIsFilled:)]) {
            [self.delegate HeartClickView:self afterClickIsFilled:self.isFilled];
        }
    }];
}

- (void)changeHeartStateWithAnimated:(BOOL)animated completion:(void(^)(void))completion{
    if (self.isFilled) {
        [self setFilled:NO animated:animated completion:completion];
    }else{
        [self setFilled:YES animated:animated completion:completion];
    }
}

#pragma mark - 测试
- (void)showAnimation{
    
}

@end
