//
//  testInfoView.m
//  wallpaper-elf
//
//  Created by mervin on 16/8/26.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "testInfoView.h"
#import "MERUICreator.h"
#import "Masonry.h"

@interface testInfoView (){
    UIScrollView *_scrollView;
    UIView *_continer;
    UIImageView *_headerImageView;   // Avatar imageView
    UILabel *_contentLabel;
    UIButton *_startBtn;
}

@property (assign, nonatomic) BOOL hasButton;

@end

@implementation testInfoView

- (instancetype)initWithFrame:(CGRect)frame buttonShowAllow:(BOOL)allow{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _hasButton = allow;
        [self setContentView];
    }
    return self;
}

- (void)setContentView{
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    WS(ws);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws);
    }];
    _continer = [UIView new];
    [_scrollView addSubview:_continer];
    [_continer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_scrollView);
        make.width.mas_equalTo(_scrollView);
    }];
    UIImage *headerImg = [UIImage imageNamed:@"bgEarn"];
    CGFloat scale = headerImg.size.height/headerImg.size.width;
    _headerImageView = [[UIImageView alloc] initWithImage:headerImg];
    [_continer addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(_continer);
        make.height.mas_equalTo(SCREEN_WIDTH*scale);
    }];
    UILabel *step1 = [MERUICreator createLabel:@"Step 1:" color:[UIColor blackColor] font:SYSTEM_FONT(16)];
    UILabel *step2 = [MERUICreator createLabel:@"Step 2:" color:[UIColor blackColor] font:SYSTEM_FONT(16)];
    UILabel *step3 = [MERUICreator createLabel:@"Step 3:" color:[UIColor blackColor] font:SYSTEM_FONT(16)];
    UILabel *step1Title = [MERUICreator createLabel:@"Receive questions and answers in audios from students."
                                              color:[UIColor blackColor]
                                               font:SYSTEM_FONT(16)];
    step1Title.numberOfLines = 0;
    UILabel *step2Title = [MERUICreator createLabel:@"Shoot a video of about two minutes to assess the answers in 24 hours."
                                              color:[UIColor blackColor]
                                               font:SYSTEM_FONT(16)];
    step2Title.numberOfLines = 0;
    UILabel *step3Title = [MERUICreator createLabel:@"Send back and get $1."
                                              color:[UIColor blackColor]
                                               font:SYSTEM_FONT(16)];
    step3Title.numberOfLines = 0;
    UILabel *content1 = [MERUICreator createLabel:@"You can choose how many answers to assess every day."
                                            color:[UIColor blackColor]
                                             font:SYSTEM_FONT(14)];
    content1.numberOfLines = 0;
    UILabel *content2 = [MERUICreator createLabel:@"Assessments should be more postive to encourage students."
                                            color:[UIColor blackColor]
                                             font:SYSTEM_FONT(14)];
    content2.numberOfLines = 0;
    UILabel *content3 = [MERUICreator createLabel:@"Focus more on the opinions or things students said."
                                            color:[UIColor blackColor]
                                             font:SYSTEM_FONT(14)];
    content3.numberOfLines = 0;
    UILabel *content4 = [MERUICreator createLabel:@"Grammar mistakes can be point out, but should be no more than one in an assessment."
                                            color:[UIColor blackColor]
                                             font:SYSTEM_FONT(14)];
    content4.numberOfLines = 0;
    [_continer addSubview:step1];
    [_continer addSubview:step2];
    [_continer addSubview:step3];
    [_continer addSubview:step1Title];
    [_continer addSubview:step2Title];
    [_continer addSubview:step3Title];
    [_continer addSubview:content1];
    [_continer addSubview:content2];
    [_continer addSubview:content3];
    [_continer addSubview:content4];
    [self setboundsForLabel:step1];
    [self setboundsForLabel:step2];
    [self setboundsForLabel:step3];
    [self setboundsForLabel:step1Title];
    [self setboundsForLabel:step2Title];
    [self setboundsForLabel:step3Title];
    [self setboundsForLabel:content1];
    [self setboundsForLabel:content2];
    [self setboundsForLabel:content3];
    [self setboundsForLabel:content4];

    [step1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_continer).offset(20);
        make.top.mas_equalTo(_headerImageView.mas_bottom).offset(12);
        make.size.mas_equalTo(step1.bounds.size);
    }];
    [step1Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(step1.mas_right);
        make.right.mas_equalTo(_continer).offset(-20);
        make.top.mas_equalTo(step1);
    }];
    [step2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(step1);
        make.top.mas_equalTo(step1Title.mas_bottom).offset(6);
        make.size.mas_equalTo(step1);
    }];
    [step2Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(step1Title);
        make.right.mas_equalTo(_continer).offset(-20);
        make.top.mas_equalTo(step2);
    }];
    [step3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(step2);
        make.top.mas_equalTo(step2Title.mas_bottom).offset(6);
        make.size.mas_equalTo(step3.bounds.size);
    }];
    [step3Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(step1Title);
        make.right.mas_equalTo(_continer).offset(-20);
        make.top.mas_equalTo(step3);
    }];
    [content1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(step3);
        make.right.mas_equalTo(step3Title);
        make.top.mas_equalTo(step3Title.mas_bottom).offset(13);
    }];
    [content2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(content1);
        make.right.mas_equalTo(content1);
        make.top.mas_equalTo(content1.mas_bottom).offset(4);
    }];
    [content3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(content2);
        make.right.mas_equalTo(content2);
        make.top.mas_equalTo(content2.mas_bottom).offset(4);
    }];
    [content4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(content3);
        make.right.mas_equalTo(content3);
        make.top.mas_equalTo(content3.mas_bottom).offset(4);
    }];
    UIView *lastView = nil;
    lastView = step1;
    if (self.hasButton) {
        _startBtn = [MERUICreator createButtonWithTitle:@"Get to Start" titleColor:GRAYCOLOR(0) font:SYSTEM_FONT(18) frame:CGRectMake(0, 0, SCREEN_WIDTH-40, 44) buttonType:UIButtonTypeCustom target:self action:@selector(startBtnPressed:)];
        _startBtn.backgroundColor = COLOR(255, 204, 36);
        [_continer addSubview:_startBtn];
        [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_continer).offset(20);
            make.right.mas_equalTo(_continer).offset(-20);
            make.top.mas_equalTo(content4.mas_bottom).offset(12);
            make.height.mas_equalTo(44);
        }];
        lastView = _startBtn;
    }
    [_continer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView).offset(8);
    }];
    
}

- (void)setboundsForLabel:(UIView *)view{
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 2;
}

- (void)startBtnPressed:(id)sender {
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
