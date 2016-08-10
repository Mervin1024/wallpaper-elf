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
#import "MERUICreator.h"

@interface ViewController (){
    NSMutableArray *images;
    NSInteger addedImageNum;
    BOOL isEarly;
}

@end

@implementation ViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = NewBlueColor;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addEditableImage)];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAllResponder)];
//    [self.view addGestureRecognizer:tap];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newImageBecomesTheFirstResponder:) name:NewImageBecomesTheFirstResponder object:nil];
//    images = [NSMutableArray array];
//    addedImageNum = 0;
//    [self addEditableImage];
    NSArray *evaluationTags = nil;
    for (NSString *tag in evaluationTags) {
        NSLog(@"%@",tag);
    }
//    isEarly = [dic[@"idEarly"] boolValue];
//    NSLog(@"%@",isEarly ?@"YES":@"NO");
//    NSString *res = nil;
//    NSString *returnMsg = res?:@" ";
//    
//    UILabel *lat = [MERUICreator createLabel:returnMsg color:Color_Black font:SYSTEM_FONT(32)];
//    lat.backgroundColor = Color_Gray;
//    [self.view addSubview:lat];
//    lat.center = self.view.center;
    
    
    
    
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
//    [self presentViewController:childController animated:YES completion:nil];
    
//    HeartClickView *view = [[HeartClickView alloc] init];
//    view.center = self.view.center;
//    [self.view addSubview:view];
    
    
}

//- (void)addEditableImage{
//    addedImageNum ++;
//    MEREditableImageView *view = [[MEREditableImageView alloc] initWithImage:[UIImage imageNamed:@"83146ca0gw1f4o22z0nevj20m80m8gpi.jpg"]];
//    view.deleteBlock = ^(MEREditableImageView *imageView){
//        [images removeObject:imageView];
//        [imageView removeFromSuperview];
//    };
//    view.center = self.view.center;
//    view.tag = addedImageNum;
//    [self.view addSubview:view];
//    [images addObject:view];
//}
//
//- (void)removeAllResponder{
//    [self changeFirstResponder:nil];
//}
//
//- (void)newImageBecomesTheFirstResponder:(NSNotification *)notification{
//    [self changeFirstResponder:(MEREditableImageView *)[notification object]];
//}
//
//- (void)changeFirstResponder:(MEREditableImageView *)view{
//    if (view) {
//        for (MEREditableImageView *imgView in images) {
//            [imgView setEditable:view.tag == imgView.tag ? !view.isEditable : NO];
//        }
//    }else {
//        for (MEREditableImageView *imgView in images) {
//            [imgView setEditable:NO];
//        }
//    }
//    
//}
//
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


@end
