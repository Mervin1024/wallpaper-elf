//
//  AdjustClassNumController.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/12.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "AdjustClassNumController.h"

#define TransformToChineseNum(a) \
_contentsDic[[NSString stringWithFormat:@"%ld",a]]

@interface AdjustClassNumController () {
    UIButton *_subtractBtn;
    UIButton *_addBtn;
    UIButton *_confirmBtn;
    
    UILabel *_nameLabel;
    UILabel *_numLabel; // num
    UILabel *_contentLabel;
    
    NSInteger _initialNum; // 初始课程数
    NSInteger _maxClassNum;
    NSInteger _numClassNumber;
    NSDictionary *_contentsDic;
    
    NSString *_title;
}

@end

@implementation AdjustClassNumController

- (NSInteger)currentNum{
    return _numClassNumber;
}

- (instancetype)initWithEvaluationCourseType:(EvaluationCourseType)courseType currentClassNum:(NSInteger)currentNum initNum:(NSInteger)initNum{
    if (self = [super init]) {
        // _numClass.text = [NSString  stringWithFormat:@"%ld",currentNum];
        _courseType = courseType;
        _initialNum = initNum;
        _numClassNumber = currentNum;
        _maxClassNum = courseType == EvaluationCourseTypeExam ? 7 : 1;
        _title = courseType == EvaluationCourseTypeExam ? @"Examination \n 课型数目" : @"Phonics \n 课型数目";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentsDic = @{@"1":@"一", @"2":@"二", @"3":@"三", @"4":@"四", @"5":@"五", @"6":@"六", @"7":@"七"};
    [self initUI];
    self.preferredContentSize = CGSizeMake(254, 300);
    self.view.layer.cornerRadius = 5.0f;
}

- (void)initUI {
    _subtractBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _subtractBtn.frame = CGRectMake(47, 124, 30, 30);
    _subtractBtn.backgroundColor = [UIColor clearColor];
    _subtractBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [_subtractBtn setTitle:@"-" forState:UIControlStateNormal];
    [_subtractBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_subtractBtn addTarget:self action:@selector(subtractBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_subtractBtn];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addBtn.frame = CGRectMake(190, 124, 30, 30);
    _addBtn.backgroundColor = [UIColor clearColor];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
    [self setButtonEnable];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(83, 30, 101, 52);
    _nameLabel.font = SYSTEM_FONT(17);
    _nameLabel.text  = _title;
    _nameLabel.lineBreakMode =  NSLineBreakByCharWrapping;
    _nameLabel.numberOfLines = 0;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    NSRange allRange = [_nameLabel.text rangeOfString:_nameLabel.text];
    NSMutableParagraphStyle *tempParagraph = [[NSMutableParagraphStyle alloc] init];
    tempParagraph.lineSpacing = 10;
    tempParagraph.alignment = NSTextAlignmentCenter;
    // tempParagraph.firstLineHeadIndent = 20.f;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_nameLabel.text];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:tempParagraph} range:allRange];
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    _nameLabel.frame = CGRectMake(83, 30, rect.size.width, rect.size.height);
    _nameLabel.center = CGPointMake(137, _nameLabel.center.y);
    _nameLabel.attributedText = attrStr;
    [_nameLabel sizeToFit];
    [self.view addSubview:_nameLabel];
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.frame = CGRectMake(115, 106, 50, 60);
    _numLabel.font = [UIFont systemFontOfSize:48];
    _numLabel.textColor = [UIColor colorWithRed:240 / 255.0f green:184 / 255.0 blue:1 / 255.0 alpha:1];
    
    _numLabel.text  = [NSString stringWithFormat:@"%ld",_numClassNumber];
    [_numLabel sizeToFit];
    _numLabel.center = CGPointMake(137, _addBtn.center.y);
    [self.view addSubview:_numLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.frame = CGRectMake(99, 168, 214, 14);
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textColor = [UIColor colorWithRed:157 / 255.0f green:157 / 255.0 blue:157 / 255.0 alpha:1];
    _contentLabel.text = [self courseString];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
//    [_contentLabel sizeToFit];
    _contentLabel.center = CGPointMake(137, _contentLabel.center.y);
    
    [self.view addSubview:_contentLabel];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _confirmBtn.frame = CGRectMake(30, 239, 214, 40);
    _confirmBtn.layer.cornerRadius = 5.0f;
    _confirmBtn.backgroundColor = [UIColor colorWithRed:255 / 255.0f green:204 / 255.0 blue:36 / 255.0 alpha:1];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    
    
}
- (void)confirmBtnPressed:(id)sender {
    __weak AdjustClassNumController *weakself = self;
    [self.delegate confirmBtnPressed:weakself content:[self courseString]]; //
}
- (void)subtractBtnPressed:(id)sender {
//    if (_numClassNumber <= 0) {
//        _contentLabel.text =  [NSString stringWithFormat:@"取消该课程"];
//        _subtractBtn.userInteractionEnabled = NO;
//        _subtractBtn.alpha = 0.4;
//        return;
//    }
    _numClassNumber--;
    _contentLabel.text = [self courseString];
    _numLabel.text = [NSString stringWithFormat:@"%ld", (long)_numClassNumber];
    [_numLabel sizeToFit];
    
    [self setButtonEnable];
}

- (void)addBtnPressed:(id)sender {
//    if (_numClassNumber >= _maxClassNum) {
//        _contentLabel.text = [self courseString];
//        [self setButtonEnable];
//        return;
//    }
    _numClassNumber++;
    _contentLabel.text = [self courseString];
    _numLabel.text = [NSString stringWithFormat:@"%ld", (long)_numClassNumber];
    [_numLabel sizeToFit];
    
    [self setButtonEnable];
    
}


- (NSString *)courseString{
    if (_numClassNumber <= 0) {
        return @"取消该课程";
    }
    if (_numClassNumber == _initialNum) {
        return @"数目不变";
    }
    if (_numClassNumber > _initialNum) {
        NSString *num = TransformToChineseNum((_numClassNumber - _initialNum));
        return [NSString stringWithFormat:@"增加%@节课",num];
    } else {
        NSString *num = TransformToChineseNum((_initialNum - _numClassNumber));
        return [NSString stringWithFormat:@"减少%@节课",num];
    }
}

- (void)setButtonEnable{
    _addBtn.userInteractionEnabled = YES;
    _addBtn.alpha = 1.0;
    
    _subtractBtn.userInteractionEnabled = YES;
    _subtractBtn.alpha = 1.0;
    if (_numClassNumber >= _maxClassNum) {
        _addBtn.userInteractionEnabled = NO;
        _addBtn.alpha = 0.4;
        
    }
    if (_numClassNumber <= 0){
        _subtractBtn.userInteractionEnabled = NO;
        _subtractBtn.alpha = 0.4;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
