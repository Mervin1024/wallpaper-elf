//
//  TagSelectViewController.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/15.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagSelectViewController : UIViewController

@property (nonatomic, copy) NSString *evaluationTitle; // 评价标题
@property (nonatomic, copy) NSArray *evaluationItems; // 所有评价条目
@property (nonatomic, copy, readonly) NSArray *selectedItems; // 已选中项目
@property (nonatomic, assign, readonly) CGFloat viewHeight;

- (instancetype)initWithTitle:(NSString *)title evaluations:(NSArray *)evaluations;

@end
