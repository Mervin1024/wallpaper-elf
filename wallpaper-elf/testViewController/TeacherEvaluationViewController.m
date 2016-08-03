//
//  ViewController.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/11.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "TeacherEvaluationViewController.h"
#import "AdjustClassNumController.h"
#import "MERBoolHelper.h"
#import "MERUICreator.h"
#import "BFEPopTableViewController.h"
#import "BFEPopMenuView.h"

@interface TeacherEvaluationViewController ()<UIPopoverControllerDelegate,AdjustClassNumControllerDelegate>{
    // 假数据
    NSArray *difficultyTitles;
    NSArray *abroadTitles;
    
    NSInteger _studentId;
    NSInteger _teacherId;
    NSString *_courseId;
    NSString *_courseName;
    NSString *_courseType;
    NSInteger _examinationAmount;
    NSInteger _phonicsAmount;
    NSInteger _difficultyAdjust;
    NSString *_abroadPlan;
    
    EvaluationCourseType _evaluationCourseType;
    UIPopoverController *_popController;
    BFEPopTableViewController *_popTableViewController;
    AdjustClassNumController *_adjustClassNumController;
//    BFETeacherServer *_server;
    
    NSInteger _initExaminationNum;
    NSInteger _initPhonicsNum;
    NSInteger _initDifficultyAdjust;
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

- (instancetype)init{
    if (self = [super init]) {
        // 设定默认值
        _evaluationCourseType = EvaluationCourseTypeExam;
    }
    return self;
}

- (instancetype)initWithWorkOrderId:(NSString *)workOrderId {
    self = [self init];
    _workOrderId = workOrderId;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
//    [self commontServerInit];
    [self performSelector:@selector(getDefaultInfo) withObject:nil afterDelay:0.5];
}

- (void)initData {
    // 假数据默认值
    _courseName = @"12345";
    difficultyTitles = @[@"难度需降低",@"难度合适",@"难度需升高"];
    abroadTitles = @[@"无",@"美国",@"英国",@"加拿大",@"澳大利亚",@"其他"];
    _examinationAmount = _initExaminationNum = 1;
    _difficultyAdjust = _initDifficultyAdjust = 0;
    _phonicsAmount = _initPhonicsNum = 1;
    _abroadPlan = @"无";
    _studentName = @"盒子鱼";
}

- (void)getDefaultInfo {

    
            _examinationAmount = _initExaminationNum = 2;
            _difficultyAdjust = _initDifficultyAdjust = 0;
            _phonicsAmount = _initPhonicsNum = 1;
            _abroadPlan = @"无";
    
    
    
//        [self creatTopView];
        [self creatCustomView];
    
}

- (void)dealloc{
    bgImageView = nil;
    avatarImageView = nil;
    backView = nil;
    courseTitleLabel = nil;
    userNameLabel = nil;
}

//- (void)creatTopView {
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    WS(ws);     // weakSelf
//    // 底层view
//    topView = [UIView new];
//    topView.backgroundColor = NewBlackColor;
//    [self.view addSubview:topView];
//    // 界面标题
//    titleLable = [MERUICreator createLabel:@"完课评价" color:NewWhiteColor font:IPAD ? SYSTEM_FONT(17) : SYSTEM_FONT(17)];
//    [topView addSubview:titleLable];
//    
//    //适配
//    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.and.top.mas_equalTo(ws.view);
//        make.height.mas_equalTo(@64);
//    }];
//    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(topView);
//        make.top.mas_equalTo(topView.mas_top).offset(33);
//    }];
//    
//}

- (void)creatCustomView{
    
    WS(ws); // __weak self
    
    // 白色底层view
    backView = [[UIView alloc] init];
    backView.backgroundColor = NewGrayColor;
    [self.view addSubview:backView];
    
    // 课程背景图片
    bgImageView = [[UIImageView alloc] init];
//    [bgImageView sd_setImageWithURL:[NSURL URLWithString:self.courseIconUrl]];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.layer.masksToBounds = YES;
    [backView addSubview:bgImageView];
    
    // 头像
    avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 78, 78)];
//    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.figureUrl]];
    avatarImageView.backgroundColor = NewGrayColor;
    avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.width/2;
    avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarImageView.layer.borderWidth = 2;
    avatarImageView.layer.masksToBounds = YES;
    [backView addSubview:avatarImageView];
    
    // 课程标题
    courseTitleLabel = [MERUICreator createLabel:_courseName color:NewWhiteColor font:SYSTEM_FONT(IPAD ? 20 : 18)];
    [bgImageView addSubview:courseTitleLabel];
    
    // 用户名称
    userNameLabel = [MERUICreator createLabel:_studentName color:NewBlackColor font:SYSTEM_FONT(IPAD ? 16 : 14)];
    [backView addSubview:userNameLabel];
    
    // 提交评价
    submitButton = [MERUICreator createButtonWithTitle:@"提    交" titleColor:Color_Red font:SYSTEM_FONT(35) target:self action:@selector(submitEvaluation)];
//                           createButtonWithNormalImage:@"submitBtn"
//                                            highlightedImage:@"submitBtn"
//                                                      target:self
//                                                      action:@selector(submitEvaluation)];
    [backView addSubview:submitButton];
    
    CGFloat difficultyButtonFont = IPAD ? 22 : 20;
    
    //------------ 评价按钮 ------------//
    
    // 课程难度调整
    difficultyButton = [MERUICreator createButtonWithTitle:@"课程难度调整"
                                                titleColor:COLOR(0,0,0)
                                                      font:SYSTEM_FONT(difficultyButtonFont)
                                                    target:self
                                                    action:@selector(difficultyButtonPressed:)];
    difficultyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [difficultyButton setTitleColor:COLOR(240, 184, 1) forState:UIControlStateSelected];
    
    // 课型数目调整
    numberButton = [MERUICreator createButtonWithTitle:@"课型数目调整"
                                            titleColor:COLOR(0,0,0)
                                                  font:SYSTEM_FONT(difficultyButtonFont)
                                                target:self
                                                action:@selector(numberButtonPressed:)];
    [numberButton setTitleColor:COLOR(240, 184, 1) forState:UIControlStateSelected];
    numberButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 学生出国计划
    abroadButton = [MERUICreator createButtonWithTitle:@"学生出国计划"
                                            titleColor:COLOR(0,0,0)
                                                  font:SYSTEM_FONT(difficultyButtonFont)
                                                target:self
                                                action:@selector(abroadButtonPressed:)];
    [abroadButton setTitleColor:COLOR(240, 184, 1) forState:UIControlStateSelected];
    abroadButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backView addSubview:abroadButton];
    
    // 左侧竖型黄条
    UIView *stripe_1 = [UIView new];
    stripe_1.backgroundColor = COLOR(255, 204, 36);
    [backView addSubview:stripe_1];
    UIView *stripe_2 = [UIView new];
    stripe_2.backgroundColor = COLOR(255, 204, 36);
    [backView addSubview:stripe_2];
    
    //------------ 适配 ------------//
    
    // 固定控件适配
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view).with.insets(UIEdgeInsetsMake( 64, 0, 0, 0));
    }];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(backView);
        //        make.top.mas_equalTo(backView);
        //        make.right.mas_equalTo(backView);
        make.height.mas_equalTo(@(IPAD ? 155 : 98));
    }];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(78, 78));
        make.bottom.mas_equalTo(bgImageView.mas_bottom).with.offset(78/2);
    }];
    [courseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.mas_equalTo(bgImageView.mas_top).with.offset(IPAD ? 64 : 25);
    }];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.top.mas_equalTo(avatarImageView.mas_bottom).with.offset(6);
    }];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(IPAD ? -20 : -10);
    }];
    // 评价按钮适配
    CGFloat width = CGRectGetWidth(difficultyButton.bounds);
    if (_evaluationCourseType == EvaluationCourseTypeNormal) {
        [backView addSubview:difficultyButton];
        [difficultyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(userNameLabel.mas_bottom).offset(IPAD ? 95 : 85);
            make.left.mas_equalTo(backView.mas_centerX).offset(9-width/2);
            make.width.mas_equalTo(@(width));
        }];
        [stripe_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(difficultyButton.mas_left).offset(-13);
            make.centerY.mas_equalTo(difficultyButton);
            make.size.mas_equalTo(CGSizeMake(4, IPAD ? 18 : 16));
        }];
        [stripe_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(stripe_1);
            make.top.mas_equalTo(stripe_1.mas_bottom).offset(IPAD ? 84 : 74);
            make.size.mas_equalTo(CGSizeMake(4, IPAD ? 18 : 16));
        }];
        [abroadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(stripe_2);
            make.left.and.right.mas_equalTo(difficultyButton);
        }];
    }
    if (_evaluationCourseType == EvaluationCourseTypeExam){
        [backView addSubview:difficultyButton];
        [difficultyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(userNameLabel.mas_bottom).offset(IPAD ? 85 : 65);
            make.left.mas_equalTo(backView.mas_centerX).offset(9-width/2);
            make.width.mas_equalTo(@(width));
        }];
        [stripe_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(difficultyButton.mas_left).offset(-13);
            make.centerY.mas_equalTo(difficultyButton);
            make.size.mas_equalTo(CGSizeMake(4, IPAD ? 18 : 16));
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
            make.left.and.right.mas_equalTo(difficultyButton);
        }];
        [abroadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(stripe_3);
            make.left.and.right.mas_equalTo(difficultyButton);
        }];
    }
    if (_evaluationCourseType == EvaluationCourseTypePronunciation){
        [backView addSubview:numberButton];
        [numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(userNameLabel.mas_bottom).offset(IPAD ? 95 : 85);
            make.left.mas_equalTo(backView.mas_centerX).offset(9-width/2);
            make.width.mas_equalTo(@(width));
        }];
        [stripe_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(numberButton.mas_left).offset(-13);
            make.centerY.mas_equalTo(numberButton);
            make.size.mas_equalTo(CGSizeMake(4, IPAD ? 18 : 16));
        }];
        [stripe_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(stripe_1);
            make.top.mas_equalTo(stripe_1.mas_bottom).offset(IPAD ? 84 : 74);
            make.size.mas_equalTo(CGSizeMake(4, IPAD ? 18 : 16));
        }];
        [abroadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(stripe_2);
            make.left.and.right.mas_equalTo(numberButton);
        }];
    }
}

#pragma mark - Button Action

- (void)hideCommentsView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitEvaluation{
    NSDictionary *dictionary = @{
                                 
                                 @"examinationAmount":[NSNumber numberWithInteger:_examinationAmount],
                                 @"phonicsAmount":[NSNumber numberWithInteger:_phonicsAmount],
                                 @"difficultyAdjust":[NSNumber numberWithInteger:_difficultyAdjust],
                                 @"abroadPlan":_abroadPlan};
//    _server.tag = TeacherEvaluationRequestType_Commit;
//    [_server postTeacherEvaluation:dictionary];
    NSLog(@"%@",dictionary);
    [self hideCommentsView];
}

// 难度调整
- (void)difficultyButtonPressed:(UIButton *)button{
    NSInteger index = [difficultyTitles indexOfObject:button.titleLabel.text];
    if (IPHONE) {
        BFEPopMenuView *popView = [[BFEPopMenuView alloc] init];
        popView.menuTitles = difficultyTitles;
        popView.currentIndex = index;
        [popView showWithSelected:^(NSInteger index) {
            [difficultyButton setTitle:difficultyTitles[index] forState:UIControlStateNormal];
            _difficultyAdjust = _initDifficultyAdjust - 1 + index;
        }];
    }
    if (IPAD) {
        difficultyButton.selected = YES;
        _popTableViewController = [[BFEPopTableViewController alloc] initWithTitleLists:difficultyTitles andCurrentIndex:index andSelected:^(NSInteger index) {
            [difficultyButton setTitle:difficultyTitles[index] forState:UIControlStateNormal];
            _difficultyAdjust = _initDifficultyAdjust - 1 + index;
            [_popController dismissPopoverAnimated:YES];
            difficultyButton.selected = NO;
        }];
        if (_popController && _popController.isPopoverVisible) {
            [_popController dismissPopoverAnimated:NO];
            _popController.delegate = nil;
            _popController = nil;
        }
        _popController = [[UIPopoverController alloc] initWithContentViewController:_popTableViewController];
        _popController.delegate = self;
        [_popController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    }
}
// 数目调整
- (void)numberButtonPressed:(UIButton *)button {
    NSInteger currentClassNum = _evaluationCourseType == EvaluationCourseTypeExam ? _examinationAmount : _phonicsAmount;
    NSInteger initClassNum = _evaluationCourseType == EvaluationCourseTypeExam ? _initExaminationNum : _initPhonicsNum;
    if (IPHONE) {
        _adjustClassNumController = [[AdjustClassNumController alloc] initWithEvaluationCourseType:_evaluationCourseType currentClassNum:currentClassNum initNum:initClassNum];
        _adjustClassNumController.delegate = self;
        _adjustClassNumController.maskView = [[UIControl alloc] init];
        _adjustClassNumController.maskView.backgroundColor = [UIColor blackColor];
        _adjustClassNumController.maskView.frame = [UIApplication sharedApplication].keyWindow.frame;
        _adjustClassNumController.maskView.alpha = 0.4;
        [_adjustClassNumController.maskView addTarget:self action:@selector(maskViewPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [[UIApplication sharedApplication].keyWindow addSubview:_adjustClassNumController.maskView]; // add mask layer
        [_adjustClassNumController.view setFrame:CGRectMake(50, 100, 270, 300)];
        _adjustClassNumController.view.backgroundColor = [UIColor whiteColor];
        _adjustClassNumController.view.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y + 10);
        [[UIApplication sharedApplication].keyWindow addSubview:_adjustClassNumController.view];
        [UIView animateWithDuration:0.5 animations:^{ // 动画
            _adjustClassNumController.view.center = [UIApplication sharedApplication].keyWindow.center;
        }];
        
        [self addChildViewController:_adjustClassNumController];
        
    }
    if (IPAD) {
        numberButton.selected = YES;
        numberButton.titleLabel.textColor = COLOR(240, 184, 1);
        _adjustClassNumController = [[AdjustClassNumController alloc] initWithEvaluationCourseType:_evaluationCourseType currentClassNum:currentClassNum initNum:initClassNum];
        _adjustClassNumController.delegate = self;
        if (_popController && _popController.isPopoverVisible) {
            [_popController dismissPopoverAnimated:NO];
            _popController.delegate = nil;
            _popController = nil;
        }
        _popController = [[UIPopoverController alloc] initWithContentViewController:_adjustClassNumController];
        _popController.delegate = self;
        [_popController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    }
}
// 出国
- (void)abroadButtonPressed:(UIButton *)button{
    abroadButton.titleLabel.textColor = COLOR(240, 184, 1);
    NSInteger index = [abroadTitles indexOfObject:button.titleLabel.text];
    if (IPHONE) {
        BFEPopMenuView *popView = [[BFEPopMenuView alloc] init];
        popView.menuTitles = abroadTitles;
        popView.currentIndex = index;
        [popView showWithSelected:^(NSInteger index) {
            [abroadButton setTitle:abroadTitles[index] forState:UIControlStateNormal];
            _abroadPlan = abroadButton.titleLabel.text;
            
        }];
    }
    if (IPAD) {
        abroadButton.selected = YES;
        _popTableViewController = [[BFEPopTableViewController alloc] initWithTitleLists:abroadTitles andCurrentIndex:index andSelected:^(NSInteger index) {
            [abroadButton setTitle:abroadTitles[index] forState:UIControlStateNormal];
            [_popController dismissPopoverAnimated:YES];
            abroadButton.selected = NO;
            _abroadPlan = abroadButton.titleLabel.text;
        }];
        if (_popController && _popController.isPopoverVisible) {
            [_popController dismissPopoverAnimated:NO];
            _popController.delegate = nil;
            _popController = nil;
        }
        _popController = [[UIPopoverController alloc] initWithContentViewController:_popTableViewController];
        _popController.delegate = self;
        [_popController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    }
    
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    if (_popController) {
        [_popController dismissPopoverAnimated:NO];
        _popController.delegate = nil;
        _popController = nil;
    }
    _popTableViewController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    difficultyButton.selected = NO;
    numberButton.selected = NO;
    abroadButton.selected = NO;
    return YES;
}

#pragma mark - AdjustClassNumControllerDelegate
-(void)confirmBtnPressed:(AdjustClassNumController *)classNumController content:(NSString *)content{
    //    NSLog(@"%@",content);
    [numberButton setTitle:content forState:UIControlStateNormal];
    if (classNumController.courseType == EvaluationCourseTypeExam) {
        _examinationAmount = classNumController.currentNum;
    }else{
        _phonicsAmount = classNumController.currentNum;
    }
    if (IPAD) {
        [_popController dismissPopoverAnimated:YES];
        numberButton.selected = NO;
    } else if (IPHONE) {
        [_adjustClassNumController.maskView removeFromSuperview];
        [_adjustClassNumController.view removeFromSuperview];
        [_adjustClassNumController removeFromParentViewController];
        
        _adjustClassNumController = nil;
    }
}
- (void)maskViewPressed:(UIControl *)maskView {
    //    [numberButton setTitle:@"课程数不变" forState:UIControlStateNormal];
    [_adjustClassNumController.maskView removeFromSuperview];
    [_adjustClassNumController.view removeFromSuperview];
    [_adjustClassNumController removeFromParentViewController];
    
    _adjustClassNumController = nil;
}



@end
