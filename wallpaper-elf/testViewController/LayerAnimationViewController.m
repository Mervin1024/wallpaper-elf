//
//  LayerAnimationViewController.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/15.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "LayerAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Masonry.h"
#import "MERUICreator.h"
#import "LayerAnimationView.h"

#define TeachButtonColor COLOR(255, 216, 87)

@interface LayerAnimationViewController ()<CAAnimationDelegate>{
    UIView *layerView;
    UIButton *_teachButton;
    NSMutableArray *_animationLayers;
    LayerAnimationView *_layerAnimationView;
}

@end

@implementation LayerAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_White;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    _animationLayers = [NSMutableArray array];
    [self creatTeachButton];
//    [self creatViews];
////    [self addBlueLayer];
//    [self addImageLayer];
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

- (NSAttributedString *)stringWithSelected:(BOOL)selected{
    if (selected) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Waiting...\nEnd Teaching" attributes:@{NSForegroundColorAttributeName:GRAYCOLOR(0),NSFontAttributeName:SYSTEM_FONT(26)}];
        NSRange grayRange = NSMakeRange([[str string] rangeOfString:@"End Teaching"].location, [[str string] rangeOfString:@"End Teaching"].length);
        [str addAttributes:@{NSForegroundColorAttributeName:GRAYCOLOR(91),
                             NSFontAttributeName:SYSTEM_FONT(16)}
                     range:grayRange];
        return str;
    }else{
        return [[NSMutableAttributedString alloc] initWithString:@"Teach\nNOW" attributes:@{NSForegroundColorAttributeName:GRAYCOLOR(0),NSFontAttributeName:SYSTEM_FONT(26)}];
    }
}


- (void)creatTeachButton{
    _teachButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_teachButton setFrame:CGRectMake(0, 0, 130, 130)];
    [_teachButton setBackgroundColor:COLOR(255, 216, 87)];
    [_teachButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_teachButton setAttributedTitle:[self stringWithSelected:NO] forState:UIControlStateNormal];
    [_teachButton setAttributedTitle:[self stringWithSelected:YES] forState:UIControlStateSelected];
    [_teachButton setTintColor:[UIColor clearColor]];
    [_teachButton.titleLabel setFont:SYSTEM_FONT(26)];
    [_teachButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_teachButton.titleLabel setNumberOfLines:2];
    _teachButton.layer.cornerRadius = 130/2;
    _teachButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _teachButton.layer.shadowOffset = CGSizeMake(2, 2);
    _teachButton.layer.shadowOpacity = 0.35;
    _teachButton.layer.shadowRadius = 5;
    [_teachButton setSelected:NO];
    [_teachButton addTarget:self action:@selector(teachButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_teachButton];
    WS(weakSelf);
    [_teachButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(130, 130));
    }];
}


- (void)teachButtonPressed:(UIButton *)button{
    [button setSelected:!button.selected];
    if (button.selected) {                      // 上线打卡
        button.layer.shadowOpacity = 0;
        [self addAnimationForTeachButton];
        NSLog(@"%@",@"====== 上线打卡!");
    }else{                                      // 下线打卡
        button.layer.shadowOpacity = 0.35;
        [self removeAnimationForTeachButton];
        NSLog(@"%@",@"====== 下线打卡!");
    }
}

- (void)addAnimationForTeachButton{
    _layerAnimationView = [[LayerAnimationView alloc] initWithFrame:CGRectMake(0, 0, 135, 135)];
    _layerAnimationView.center = _teachButton.center;
    [self.view insertSubview:_layerAnimationView belowSubview:_teachButton];
}

- (void)removeAnimationForTeachButton{
    if (_layerAnimationView) {
        [_layerAnimationView removeFromSuperview];
        _layerAnimationView = nil;
    }
}


- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
