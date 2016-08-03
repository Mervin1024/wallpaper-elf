//
//  AdjustClassNumController.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/12.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherEvaluationViewController.h"

@class AdjustClassNumController;

@protocol AdjustClassNumControllerDelegate <NSObject>

- (void)confirmBtnPressed:(AdjustClassNumController *)ClassNumController content:(NSString *)content; // 点击了确定

@end

@interface AdjustClassNumController : UIViewController

- (instancetype)initWithEvaluationCourseType:(EvaluationCourseType)courseType currentClassNum:(NSInteger)currentNum initNum:(NSInteger)initNum;
@property (nonatomic, weak) id<AdjustClassNumControllerDelegate> delegate;
@property (strong, nonatomic) UIControl *maskView; // 遮罩层
@property (nonatomic, assign, readonly) NSInteger currentNum;
@property (nonatomic, assign) EvaluationCourseType courseType;
@end