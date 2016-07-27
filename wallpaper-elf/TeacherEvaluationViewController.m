//
//  ViewController.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/11.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "TeacherEvaluationViewController.h"
#import "MERBoolHelper.h"
#import "MERUICreator.h"

@interface TeacherEvaluationViewController (){
    // 假数据
    NSString *bgImageName;
    NSString *avatarImageName;
    NSString *courseTitle;
    NSString *userName;
}

@end

@implementation TeacherEvaluationViewController{
//-----------伪 Navigationbar-----------//
    UIView *topView;                // 底层view
    UILabel *titleLable;            // 界面标题
//-----------content-----------//
    UIImageView *bgImageView;   // 课程背景图片
    UIImageView *avatarImageView;   // 头像
    UIView *backView;           // 白色底层view
    UILabel *courseTitleLabel;  // 课程标题
    UILabel *userNameLabel;     // 用户名称
    UIButton *submitButton;     // 提交评价
    UIButton *difficultyButton; // 课程难度调整
    UIButton *numberButton;     // 课型数目调整
    UIButton *abroadButton;     // 学生出国计划
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"完课评价";
    
    bgImageName = @"";
    avatarImageName = @"83146ca0gw1f4o22z0nevj20m80m8gpi.jpg";
    userName = @"何子瑜";
    courseTitle = @"奥斯卡最佳动画《超能陆战队》";
    
    [self creatCustomView];
    
}

- (void)dealloc{
    bgImageView = nil;
    avatarImageView = nil;
    backView = nil;
    courseTitleLabel = nil;
    userNameLabel = nil;
}

- (void)creatCustomView{
    CGFloat backViewOffset = [MERBoolHelper isPad] ? 155 : 98;
    CGFloat courseTitleOffset =  [MERBoolHelper isPad] ? 64 : 25;
    CGFloat courseTitleFont = [MERBoolHelper isPad] ? 20 : 18;
    CGFloat userNameFont = [MERBoolHelper isPad] ? 16 : 14;
    CGFloat submitOffset = [MERBoolHelper isPad] ? -20 : -10;
    
    WS(ws); // __weak self
    
    // 白色底层view
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    // 课程背景图片
    bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImageName]];
    
    bgImageView.backgroundColor = NewYellowColor;
    
    [backView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.top.mas_equalTo(backView);
        make.height.mas_equalTo(@(backViewOffset));
    }];
    
    // 头像
    CGRect imageBounds = CGRectMake(0, 0, 78, 78);
    avatarImageView = [[UIImageView alloc] initWithFrame:imageBounds];
    [avatarImageView setImage:[UIImage imageNamed:avatarImageName]];
    avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.width/2;
    avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarImageView.layer.borderWidth = 2;
    avatarImageView.layer.masksToBounds = YES;
    [self.view addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(78, 78));
        make.bottom.mas_equalTo(bgImageView.mas_bottom).with.offset(78/2);
    }];
    
    // 课程标题
    courseTitleLabel = [MERUICreator createLabel:courseTitle color:NewWhiteColor font:SYSTEM_FONT(courseTitleFont)];
    [bgImageView addSubview:courseTitleLabel];
    [courseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.mas_equalTo(bgImageView.mas_top).with.offset(courseTitleOffset);
    }];
    
    // 用户名称
    userNameLabel = [MERUICreator createLabel:userName color:NewBlackColor font:SYSTEM_FONT(userNameFont)];
    [backView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.top.mas_equalTo(avatarImageView.mas_bottom).with.offset(6);
    }];
    
    // 提交评价
    submitButton = [MERUICreator createButtonWithNormalImage:@"submitBtn"
                                            highlightedImage:@"submitBtn"
                                                      target:self
                                                      action:@selector(submitEvaluation)];
    submitButton.backgroundColor = NewYellowColor;
    [backView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(submitOffset);
        make.size.mas_equalTo(CGSizeMake(345, 44));
    }];
    
    CGFloat difficultyButtonFont = [MERBoolHelper isPad] ? 22 : 20;
    
    //------------评价按钮------------//
    
    // 课程难度调整
    difficultyButton = [MERUICreator createButtonWithTitle:@"课程难度调整"
                                                titleColor:COLOR(0,0,0)
                                                      font:SYSTEM_FONT(difficultyButtonFont)
                                                    target:self
                                                    action:@selector(adjustCourseDifficulty:)];
    [backView addSubview:difficultyButton];
    
    // 课型数目调整
    numberButton = [MERUICreator createButtonWithTitle:@"课型数目调整"
                                            titleColor:COLOR(0,0,0)
                                                  font:SYSTEM_FONT(difficultyButtonFont)
                                                target:self
                                                action:@selector(adjustTheNumberOfCourseType:)];
    // 学生出国计划
    abroadButton = [MERUICreator createButtonWithTitle:@"学生出国计划"
                                            titleColor:COLOR(0,0,0)
                                                  font:SYSTEM_FONT(difficultyButtonFont)
                                                target:self
                                                action:@selector(adjustTheNumberOfCourseType:)];
    [backView addSubview:abroadButton];
    
    // 左侧竖型黄条
    UIView *stripe_1 = [UIView new];
    stripe_1.backgroundColor = COLOR(255, 204, 36);
    [backView addSubview:stripe_1];
    UIView *stripe_2 = [UIView new];
    stripe_2.backgroundColor = COLOR(255, 204, 36);
    [backView addSubview:stripe_2];
    
//    if (self.courseType == EvaluationCourseTypeNormal) {
//        [difficultyButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(userNameLabel.mas_bottom).offset([self isPad] ? 95 : 85);
//            make.centerX.mas_equalTo(backView.mas_centerX).offset(9);
//        }];
//        [stripe_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(difficultyButton.mas_left).offset(-13);
//            make.centerY.mas_equalTo(difficultyButton);
//            make.size.mas_equalTo(CGSizeMake(4, [self isPad] ? 18 : 16));
//        }];
//        [stripe_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(stripe_1);
//            make.top.mas_equalTo(stripe_1.mas_bottom).offset([self isPad] ? 84 : 74);
//            make.size.mas_equalTo(CGSizeMake(4, [self isPad] ? 18 : 16));
//        }];
//        [abroadButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(stripe_2);
//            make.left.mas_equalTo(difficultyButton);
//        }];
//    }else{
        [difficultyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(userNameLabel.mas_bottom).offset([MERBoolHelper isPad] ? 85 : 65);
            make.centerX.mas_equalTo(backView.mas_centerX).offset(9);
        }];
        [stripe_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(difficultyButton.mas_left).offset(-13);
            make.centerY.mas_equalTo(difficultyButton);
            make.size.mas_equalTo(CGSizeMake(4, [MERBoolHelper isPad] ? 18 : 16));
        }];
        [stripe_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(stripe_1);
            make.top.mas_equalTo(stripe_1.mas_bottom).offset(74);
            make.size.mas_equalTo(stripe_1);
        }];
        UIView *stripe_3 = [UIView new];
        stripe_3.backgroundColor = COLOR(255, 204, 36);
        [backView addSubview:stripe_3];
        [stripe_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(stripe_2);
            make.top.mas_equalTo(stripe_2.mas_bottom).offset(74);
            make.size.mas_equalTo(stripe_1);
        }];
        [backView addSubview:numberButton];
        [numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(stripe_2);
            make.left.mas_equalTo(difficultyButton);
        }];
        [abroadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(stripe_3);
            make.left.mas_equalTo(difficultyButton);
        }];
    
    
    
//    }
}

#pragma mark - Button Action

//- (void)hideCommentsView{
//    //    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}

- (void)submitEvaluation{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)adjustCourseDifficulty:(UIButton *)button{
    
}

- (void)adjustTheNumberOfCourseType:(UIButton *)button{
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

@end
