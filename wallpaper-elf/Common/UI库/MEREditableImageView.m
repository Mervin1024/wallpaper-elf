//
//  MEREditableImageView.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/29.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "MEREditableImageView.h"

@interface MEREditableImageView ()

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation MEREditableImageView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = Color_Clear;
        self.userInteractionEnabled = YES;
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClicked)];
        [self addGestureRecognizer:_tap];
    }
    return self;
}

#pragma mark - Action

- (void)imageDidClicked{
    
}

@end
