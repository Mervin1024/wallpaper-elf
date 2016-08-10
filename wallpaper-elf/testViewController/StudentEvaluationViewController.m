//
//  StudentEvaluationViewController.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/27.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "StudentEvaluationViewController.h"
#import "HeartClickView.h"
#import "TagSelectViewController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MERUICreator.h"
#import "MBProgressHUD+MER.h"
#import <MBProgressHUD.h>

@interface StudentEvaluationViewController ()<UIScrollViewDelegate>{
    NSArray *evaluationTags; // 服务器获取的所有评论tag
    
    NSString *_figureUrl;
    NSString *_teacherName;
    
}
@property (nonatomic, assign) BOOL feedbackHidden; // 反馈部分界面是否隐藏
@property (nonatomic, copy) NSArray *feedbackItems; //提供的反馈条目
@end

@implementation StudentEvaluationViewController {
    //-----------伪 Navigationbar-----------//
    UIView *topView;                // 底层view
    UILabel *titleLable;            // 界面标题
    UIButton *submitButton;         // 右上角提交按钮
    //-----------content-----------//
    UIScrollView *backScrollView;   // 底层ScrollView
    UIView *continerView;           // 白色容器view
    UIImageView *topImageView;      // 顶部图片
    UIImageView *avatarImageView;   // 头像
    UILabel *userNameLabel;         // 用户名称
    HeartClickView *heartButton;    // 心形点赞按钮
    UIButton *feedbackButton;       // 反馈
    NSMutableArray *tagSelectViewControllers;         // 反馈分多个项目，所以分多个界面  [item class] = [TagSelectViewController class]
    NSMutableArray *feedbacksViewArray;     // 承载反馈界面的view，仅负责显示  [item class] = [UIView class]
    
}

#pragma mark - setter & getter
- (void)setFeedbackState {
    self.feedbackHidden = !self.feedbackHidden;
    if (self.feedbackHidden) {
        if (backScrollView.contentOffset.y == 0 ) {
            [self closeFeedbackView];
        }else{
            // 关闭动画在UIScrollViewDelegate中执行
            // [self closeFeedbackView];
            [backScrollView setContentOffset:CGPointZero animated:YES];
        }
        
    }else{
        [self openFeedbackView];
    }
    
}

- (NSArray *)feedbackItems{
    if (_feedbackItems.count > 0) {
        return _feedbackItems;
    }
    NSMutableArray *all = [NSMutableArray array];
    for (StudentEvaluationTag *tag in evaluationTags) {
        [self addEvaluationTag:tag toArray:all];
    }
    return all;
}

- (void)addEvaluationTag:(StudentEvaluationTag *)tag toArray:(NSMutableArray *)array{
    if (array.count > 0) {
        for (NSMutableDictionary *obj in array) {
            if ([obj[@"type"] integerValue] == tag.tagType) {
                NSMutableArray *arr = obj[@"contents"];
                [arr addObject:tag];
                [obj setObject:arr forKey:@"contents"];
                return;
            }
        }
    }
    NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(tag.tagType),@"type",[NSMutableArray arrayWithObject:tag],@"contents", nil];
    [array addObject:obj];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = NewWhiteColor;
    
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitEvaluation:)];
    [self getInitialData];
    [self creatTopView];
    [self creatCustomView];
    
    
    
    
    
}

- (void)getInitialData{
    _figureUrl = @"83146ca0gw1f4o22z0nevj20m80m8gpi.jpg";
    _teacherName = @"GHSJG";
    
}

- (void)getTagsFromSever { // 从服务器获取 tags GET
    NSArray *data = @[@{@"tagName":@"长相不好",
                        @"tagCode":@"2",
                        @"tagType":ONLINE_BAD_REVIEW_TEACHER},
                      @{@"tagName":@"声音不好",
                        @"tagCode":@"3",
                        @"tagType":ONLINE_BAD_REVIEW_TEACHER},
                      @{@"tagName":@"课程不好",
                        @"tagCode":@"4",
                        @"tagType":ONLINE_COURSE_REVIEW},
                      @{@"tagName":@"网速不好",
                        @"tagCode":@"5",
                        @"tagType":ONLINE_SYSTEM_REVIEW}];
    NSMutableArray *arr = [NSMutableArray array];
    [data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        StudentEvaluationTag *tag = [[StudentEvaluationTag alloc] initWithDictionary:obj];
        [arr addObject:tag];
    }];
    evaluationTags = [NSArray arrayWithArray:arr];
    
    [self creatFeedbackView];
    [self creatCustomView];
    
}

- (void)creatTopView {
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    WS(ws);     // weakSelf
    // 底层view
    topView = [UIView new];
    topView.backgroundColor = NewWhiteColor;
    [self.view addSubview:topView];
    // 界面标题
    titleLable = [MERUICreator createLabel:@"评价" color:GRAYCOLOR(26) font:SYSTEM_FONT(18)];
    [topView addSubview:titleLable];
    // 右上角提交按钮
    submitButton = [MERUICreator createButtonWithTitle:@"提交"
                                            titleColor:COLOR(255, 196, 0)
                                                  font:SYSTEM_FONT(16)
                                                target:self
                                                action:@selector(submitEvaluation:)];
    [topView addSubview:submitButton];
    
    //适配
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(ws.view);
        make.height.mas_equalTo(@64);
    }];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topView);
        make.top.mas_equalTo(topView.mas_top).offset(33);
    }];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView.mas_right).offset(-14);
        make.top.mas_equalTo(topView.mas_top).offset(31);
    }];
    
}

- (void)creatCustomView{
    WS(ws);     // weakSelf
    
    //------------- 主要控件 -------------//
    if (backScrollView) {
        [backScrollView removeFromSuperview];
        backScrollView = nil;
    }
    // 底层ScrollView
    backScrollView = [UIScrollView new];
    backScrollView.delegate = self;
    //  backScrollView.bounces = NO;
    backScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScrollView];
    
    // 白色容器view
    continerView = [UIView new];
    continerView.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:continerView];
    
    // 顶部图片
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone6Copy2"]];
    [continerView addSubview:topImageView];
    CGFloat scale = CGRectGetHeight(topImageView.frame)/CGRectGetWidth(topImageView.frame);
    
    // 头像
    avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    [avatarImageView setImage:[UIImage imageNamed:_figureUrl]];
    avatarImageView.backgroundColor = NewGrayColor;
    avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.width/2;
    avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarImageView.layer.borderWidth = 2;
    avatarImageView.layer.masksToBounds = YES;
    [continerView addSubview:avatarImageView];
    
    // 用户名称
    userNameLabel = [MERUICreator createLabel:_teacherName color:GRAYCOLOR(26) font:SYSTEM_FONT(18)];
    [continerView addSubview:userNameLabel];
    
    // 心形点赞按钮
    if (!heartButton) {
        heartButton = [HeartClickView new];
    }
//    heartButton = [HeartClickView new];
    [continerView addSubview:heartButton];
    
    // 反馈
    feedbackButton = [MERUICreator createButtonWithTitle:@"反馈" titleColor:COLOR(255, 204, 36) font:SYSTEM_FONT(18) target:self action:@selector(feedbackButtonPressed:)];
    _feedbackHidden = YES;
    [continerView addSubview:feedbackButton];
    
    //------------- 其他控件 -------------//
    UILabel *message1 = [MERUICreator createLabel:@"给老师点个赞" color:GRAYCOLOR(102) font:SYSTEM_FONT(16)];
    [continerView addSubview:message1];
    
    UIView *grayLine1 = [UIView new];
    grayLine1.backgroundColor = GRAYCOLOR(184);
    UIView *grayLine2 = [UIView new];
    grayLine2.backgroundColor = GRAYCOLOR(184);
    [continerView addSubview:grayLine1];
    [continerView addSubview:grayLine2];
    
    //-------------  适配  -------------//
    
    [backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    [continerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(backScrollView);
        make.width.mas_equalTo(backScrollView);
    }];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(continerView);
        make.height.mas_equalTo(continerView.mas_width).multipliedBy(scale);
    }];
    [message1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(continerView);
        make.top.mas_equalTo(topImageView.mas_bottom).with.offset(1);
    }];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(72, 72));
        make.top.mas_equalTo(topImageView.mas_bottom).with.offset(34);
        make.centerX.mas_equalTo(continerView);
    }];
    [grayLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(continerView.mas_left).offset(15);
        make.right.mas_equalTo(avatarImageView.mas_left).offset(-24);
        make.top.mas_equalTo(topImageView.mas_bottom).offset(49);
        make.height.mas_equalTo(@2);
    }];
    [grayLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(continerView.mas_right).offset(-15);
        make.left.mas_equalTo(avatarImageView.mas_right).offset(24);
        make.top.and.height.mas_equalTo(grayLine1);
    }];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(continerView);
        make.top.mas_equalTo(avatarImageView.mas_bottom).with.offset(4);
    }];
    [heartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(continerView);
        make.top.mas_equalTo(userNameLabel.mas_bottom).with.offset(80);
        make.size.mas_equalTo(CGSizeMake(54, 50));
    }];
    CGFloat feedOffset = SCREEN_HEIGHT-64-51;
    [feedbackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(continerView);
        make.bottom.mas_equalTo(continerView.mas_top).with.offset(feedOffset);
    }];
    
    UIView *lastview = nil;
    for (int i = 0; i < feedbacksViewArray.count; i++) {
        UIView *view = feedbacksViewArray[i];
        [continerView addSubview:view];
        TagSelectViewController *con = (TagSelectViewController *)tagSelectViewControllers[i];
        CGSize size = con.viewSize;
        if (i == 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
                make.top.mas_equalTo(feedbackButton.mas_bottom).offset(31);
                make.left.mas_equalTo(continerView);
            }];
        } else if (i == feedbacksViewArray.count -1) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
                make.top.mas_equalTo(lastview.mas_bottom).offset(40);
                make.left.mas_equalTo(lastview);
            }];
        } else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
                make.top.mas_equalTo(lastview.mas_bottom).offset(40);
                make.left.mas_equalTo(lastview);
            }];
        }
        lastview = view;
        view.hidden = YES;
    }
    if (!lastview) {
        lastview = feedbackButton;
    }
    
    [continerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastview.mas_bottom).offset(90);
    }];
    backScrollView.scrollEnabled = NO;
}

- (void)creatFeedbackView {
    feedbacksViewArray = [NSMutableArray array];
    tagSelectViewControllers = [NSMutableArray array];
    for (NSDictionary *dic in self.feedbackItems) {
        TagSelectViewController *controller = [[TagSelectViewController alloc] initWithEvaluationTagType:[dic[@"type"] integerValue] evaluationTags:dic[@"contents"]];
        [tagSelectViewControllers addObject:controller];
        CGSize size = controller.viewSize;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [self addChildViewController:controller];
        [view addSubview:controller.view];
        [feedbacksViewArray addObject:view];
    }
}

#pragma mark - Button Action
// 提交
- (void)submitEvaluation:(id)sender {
    [self submitEvaluationTags];
}

- (void)feedbackButtonPressed:(UIButton *)button {
    if (evaluationTags.count == 0) {
        [self getTagsFromSever];
        [MBProgressHUD showHUDAddedTo:backScrollView animated:YES];
        [self performSelector:@selector(setFeedbackState) withObject:nil afterDelay:0.1];
    }else{
        [self setFeedbackState];
    }
    
}

- (void)openFeedbackView {
    for (UIView *view in feedbacksViewArray) {
        view.hidden = NO;
    }
    backScrollView.scrollEnabled = YES;
    CGFloat offset = userNameLabel.frame.origin.y + userNameLabel.frame.size.height + 40;
    if (offset + (SCREEN_HEIGHT - 64) > CGRectGetHeight(continerView.bounds)) {
        offset = CGRectGetHeight(continerView.bounds) - (SCREEN_HEIGHT - 64);
    }
    [backScrollView setContentOffset:CGPointMake(0, offset) animated:YES];
}

- (void)closeFeedbackView {
    for (UIView *view in feedbacksViewArray) {
        view.hidden = YES;
    }
    backScrollView.scrollEnabled = NO;
    [backScrollView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.feedbackHidden) {
        [self closeFeedbackView];
    }
}

#pragma mark- serverStatusCallBack

- (void)submitEvaluationTags{
    NSLog(@"提交");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark server delegate
- (void)dealloc{
    NSLog(@"点评页释放");
}


@end

