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

@interface ViewController (){
    NSArray *evaluationTags; // 服务器获取的所有评论tag
}
@property (nonatomic, copy) NSArray *feedbackItems; //提供的反馈条目
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
    StudentEvaluationViewController *childController = [[StudentEvaluationViewController alloc] init];
    [self addChildViewController:childController];
    [self.view addSubview:childController.view];
    
//    HeartClickView *view = [[HeartClickView alloc] init];
//    view.center = self.view.center;
//    [self.view addSubview:view];
}


@end
