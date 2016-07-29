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
#import "TeacherEvaluationViewController.h"
#import "StudentEvaluationViewController.h"
#import "MERUITransform.h"
#import "MEREditableImageView.h"

@interface ViewController (){
    NSMutableArray *images;
}

@end

@implementation ViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NewBlueColor;
//    HeartClickView *heartView = [HeartClickView new];
//    [self.view addSubview:heartView];
//    WS(ws);
//    [heartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(ws.view);
//        
//    }];
//    LayerAnimationViewController *childController = [[LayerAnimationViewController alloc] init];
//    StudentEvaluationViewController *childController = [[StudentEvaluationViewController alloc] init];
//    [self addChildViewController:childController];
//    [self.view addSubview:childController.view];
    
//    HeartClickView *view = [[HeartClickView alloc] init];
//    view.center = self.view.center;
//    [self.view addSubview:view];
    images = [NSMutableArray array];
    MEREditableImageView *view = [[MEREditableImageView alloc] initWithImage:[UIImage imageNamed:@"83146ca0gw1f4o22z0nevj20m80m8gpi.jpg"]];
    view.deleteBlock = ^(MEREditableImageView *view){
        [images removeObject:view];
        [view removeFromSuperview];
    };
    view.center = self.view.center;
    [self.view addSubview:view];
    [images addObject:view];
    
}


@end
