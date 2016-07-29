//
//  LayerAnimationViewController.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/15.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "LayerAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LayerAnimationViewController (){
    UIView *layerView;
}

@end

@implementation LayerAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = NewYellowColor;
    
    [self creatViews];
//    [self addBlueLayer];
    [self addImageLayer];
}

- (void)creatViews{
    WS(ws);
    layerView = [UIView new];
    layerView.backgroundColor = Color_White;
    [self.view addSubview:layerView];
    [layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
}

- (void)addBlueLayer{
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor = Color_Blue.CGColor;
    [layerView.layer addSublayer:blueLayer];
    
}

- (void)addImageLayer{
    UIImage *image = [UIImage imageNamed:@"notFullHeart"];
    layerView.layer.contents = CGImageGet(image);
//    layerView.contentMode = UIViewContentModeScaleAspectFit;
    layerView.layer.contentsGravity = kCAGravityResizeAspect;
//    layerView.layer.contentsGravity = kCAGravityCenter;
//    layerView.layer.contentsScale = image.scale;
//    layerView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
}

@end
