//
//  ViewController.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/11.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIImageView *bgImageView;   // 课程背景图片
    UIImageView *avatarImage;   // 头像
    UIView *backView;           // 白色底层view
    UILabel *courseTitleLabel;  // 课程标题
    UILabel *userNameLabel;     // 用户名称
    UIButton *submitButton;     // 提交评价
    UIButton *difficultyButton; // 课程难度调整
    UIButton *numberButton;     // 课型数目调整
    UIButton *abroadButton;     // 学生出国计划
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(hideCommentsView)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.title = @"完课评价";
    
    [self creatCustomView];
    
}

- (BOOL)isPad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

- (UILabel*)createLabel:(NSString*) content color:(UIColor*) color font:(UIFont*) font
{
    CGSize size = [content sizeWithAttributes:@{ NSFontAttributeName : font }];
    
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0,0,size.width,size.height)];
    lab.text = content;
    lab.textColor = color;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    
    return lab;
}

- (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action{
    BOOL use2X = ![self isPad];
    
    return [self createButtonWithNormalImage:normalImageName
                            highlightedImage:highlightedImageName
                                      target:target
                                      action:action
                                       use2X:use2X];
}

- (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action
                                   use2X:(BOOL)use2X
//                         useIphone6Image:(BOOL)useIphone6Image
{
    UIButton* btn = [[UIButton alloc] init];
    
    UIImage* normalImage = [UIImage imageNamed:normalImageName];
    UIImage* highlightedImage = [UIImage imageNamed:highlightedImageName];
    
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    CGSize normalImageSize;
//    if (useIphone6Image) {
//        normalImageSize = [self resetImageSizeIfStudentInphoneVersion:normalImage];
//    } else {
        normalImageSize = normalImage.size;
//    }
    
    if (use2X) {
        btn.frame = CGRectMake(0, 0, normalImageSize.width/2, normalImageSize.height/2);
    } else {
        btn.frame = CGRectMake(0, 0, normalImageSize.width, normalImageSize.height);
    }
    
    return btn;
}

- (UIButton*)createButtonWithTitle:(NSString*)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont*)font
                            target:(id)target
                            action:(SEL)action
{
    CGSize size = [title sizeWithAttributes:@{ NSFontAttributeName : font }];
    size.width += [self isPad] ? 10 : 5;
    size.height += [self isPad] ? 10 : 5;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; //创建圆角矩形button
    [button setFrame:CGRectMake(0, 0, size.width, size.height)]; //设置button的frame
    [button setTitle:title forState:UIControlStateNormal]; //设置button的标题
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.backgroundColor = [UIColor clearColor];
    
    if (font) {
        button.titleLabel.font = font;
    }
    return button;
}

- (void)creatCustomView{
    CGFloat backViewOffset = [self isPad] ? 155 : 98;
    CGFloat courseTitle =  [self isPad] ? 64 : 25;
    CGFloat courseTitleFont = [self isPad] ? 20 : 18;
    CGFloat userNameFont = [self isPad] ? 16 : 14;
    CGFloat submitOffset = [self isPad] ? -20 : -10;
    
    WS(ws); // __weak self
    
    // 白色底层view
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    // 课程背景图片
    bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    
    bgImageView.backgroundColor = NewYellowColor;
    
    [backView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView);
        make.width.mas_equalTo(backView);
        make.height.mas_equalTo(@(backViewOffset));
        make.top.mas_equalTo(backView);
    }];
    
    // 头像
    avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 78, 78)];
    [avatarImage setImage:[UIImage imageNamed:@""]];
    
    avatarImage.backgroundColor = NewGrayColor;
    
    avatarImage.layer.cornerRadius = avatarImage.bounds.size.width/2;
    [self.view addSubview:avatarImage];
    [avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(78, 78));
        make.bottom.mas_equalTo(bgImageView.mas_bottom).with.offset(78/2);
    }];
    
    // 课程标题
    courseTitleLabel = [self createLabel:@"奥斯卡最佳动画《超能陆战队》" color:NewWhiteColor font:SYSTEM_FONT(courseTitleFont)];
    [bgImageView addSubview:courseTitleLabel];
    [courseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.mas_equalTo(bgImageView.mas_top).with.offset(courseTitle);
    }];
    
    // 用户名称
    userNameLabel = [self createLabel:@"何子瑜" color:NewBlackColor font:SYSTEM_FONT(userNameFont)];
    [backView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.top.mas_equalTo(avatarImage.mas_bottom).with.offset(6);
    }];
    
    // 提交评价
    submitButton = [self createButtonWithNormalImage:@"submitBtn"
                                            highlightedImage:@"submitBtn"
                                                      target:self
                                                      action:@selector(submitEvaluation)];
    [backView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(submitOffset);
    }];
    
    CGFloat difficultyButtonFont = [self isPad] ? 22 : 20;
    
    //------------评价按钮------------//
    
    // 课程难度调整
    difficultyButton = [self createButtonWithTitle:@"课程难度调整"
                                                titleColor:COLOR(0,0,0)
                                                      font:SYSTEM_FONT(difficultyButtonFont)
                                                    target:self
                                                    action:@selector(adjustCourseDifficulty:)];
    [backView addSubview:difficultyButton];
    
    // 课型数目调整
    numberButton = [self createButtonWithTitle:@"课型数目调整"
                                            titleColor:COLOR(0,0,0)
                                                  font:SYSTEM_FONT(difficultyButtonFont)
                                                target:self
                                                action:@selector(adjustTheNumberOfCourseType:)];
    // 学生出国计划
    abroadButton = [self createButtonWithTitle:@"学生出国计划"
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
            make.top.mas_equalTo(userNameLabel.mas_bottom).offset([self isPad] ? 85 : 65);
            make.centerX.mas_equalTo(backView.mas_centerX).offset(9);
        }];
        [stripe_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(difficultyButton.mas_left).offset(-13);
            make.centerY.mas_equalTo(difficultyButton);
            make.size.mas_equalTo(CGSizeMake(4, [self isPad] ? 18 : 16));
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

- (void)hideCommentsView{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)submitEvaluation{
    
}

- (void)adjustCourseDifficulty:(UIButton *)button{
    
}

- (void)adjustTheNumberOfCourseType:(UIButton *)button{
    
}
@end
