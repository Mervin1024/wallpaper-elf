//
//  ViewController.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/15.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "ViewController.h"
#import "HeartClickView.h"
#import "LayerAnimationViewController.h"
#import "TagSelectViewController.h"
#import "HeartBeatView.h"
#import "HeartClickView.h"

@interface ViewController ()

@end

@implementation ViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    HeartClickView *heartView = [HeartClickView new];
//    [self.view addSubview:heartView];
//    WS(ws);
//    [heartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(ws.view);
//        
//    }];
//    LayerAnimationViewController *childController = [[LayerAnimationViewController alloc] init];
//    TagSelectViewController *childController = [[TagSelectViewController alloc] initWithTitle:@"关于老师" evaluations:nil];
//    [self addChildViewController:childController];
//    [self.view addSubview:childController.view];
    HeartClickView *view = [[HeartClickView alloc] init];
    view.center = self.view.center;
    [self.view addSubview:view];
}




@end
