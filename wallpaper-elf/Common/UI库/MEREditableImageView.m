//
//  MEREditableImageView.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/29.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "MEREditableImageView.h"
#import "MERUICreator.h"
#import "MBProgressHUD+MER.h"

@interface MEREditableImageView (){
    UIImage *editableImage;
    
    UIImageView *containerView;
    UIImageView *editBackView;
    
    UIButton *deleteButton;     // 删除按钮
    UIButton *reversalButton;   // 翻转按钮
    UIButton *rotateButton;     // 旋转按钮
    UIButton *restoreButton;    // 复原按钮
    
    
}

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign, getter=isEditable) BOOL editable; // 是否开启可编辑状态
@property (nonatomic, assign, getter=isReversal) BOOL reversal; // 翻转状态

@end

@implementation MEREditableImageView
static CGFloat editViewOffset = 7;

#pragma mark - Initializer

- (instancetype)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        [self initializerWithImage:image];
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName{
    self = [super init];
    if (self) {
        [self initializerWithImage:[UIImage imageNamed:imageName]];
    }
    return self;
}

- (void)initializerWithImage:(UIImage *)image{
    editableImage = image;
    self.backgroundColor = Color_Clear;
    containerView = [[UIImageView alloc] initWithImage:image];
    containerView.userInteractionEnabled = YES;
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClicked)];
    [containerView addGestureRecognizer:_tap];
    
    self.bounds = CGRectMake(0, 0, WIDTH_FROM_VIEW(containerView)+editViewOffset*2, HEIGHT_FROM_VIEW(containerView)+editViewOffset*2);
    [self addSubview:containerView];
    
    [self addEditView];
    [self setEditable:NO];
    [self setReversal:NO];
}

- (void)addEditView{
    WS(ws);
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws).insets(UIEdgeInsetsMake(editViewOffset, editViewOffset, editViewOffset, editViewOffset));
    }];
    
    //编辑页面
    editBackView = [UIImageView new];
    UIImage *selectedImage = [UIImage imageNamed:@"selectedImage"];
    editBackView.image = [selectedImage resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3) resizingMode:UIImageResizingModeTile];
    editBackView.backgroundColor = Color_Clear;
    editBackView.userInteractionEnabled = YES;
    [containerView addSubview:editBackView];
    // 删除按钮
    deleteButton = [MERUICreator createButtonWithNormalImage:@"delete" highlightedImage:@"delete" target:self action:@selector(deleteButtonClicked:)];
    [self addSubview:deleteButton];
    // 翻转按钮
    reversalButton = [MERUICreator createButtonWithNormalImage:@"reversal" highlightedImage:@"reversal" target:self action:@selector(reversalButtonClicked:)];
    [self addSubview:reversalButton];
    // 旋转按钮
    rotateButton = [MERUICreator createButtonWithNormalImage:@"rotate" highlightedImage:@"rotate" target:self action:@selector(rotateButtonClicked:)];
    [self addSubview:rotateButton];
    // 复原按钮
    restoreButton = [MERUICreator createButtonWithNormalImage:@"Restore" highlightedImage:@"Restore" target:self action:@selector(restoreButtonClicked:)];
    [self addSubview:restoreButton];
    
    [editBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(containerView).insets(UIEdgeInsetsMake(-1, -1, -1, -1));
    }];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(ws);
        // 左上角
    }];
    [reversalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.mas_equalTo(ws);
        // 右上角
    }];
    [rotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.mas_equalTo(ws);
        // 右下角
    }];
    [restoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.mas_equalTo(ws);
        // 左下角
    }];
}

#pragma mark - Setter&Getter

- (void)setEditable:(BOOL)editable{
    _editable = editable;
    editBackView.hidden = !editable;
    deleteButton.hidden = !editable;
    reversalButton.hidden = !editable;
    rotateButton.hidden = !editable;
    restoreButton.hidden = !editable;
}

- (void)setReversal:(BOOL)reversal{
    _reversal = reversal;
    containerView.image = reversal ? [UIImage imageWithCGImage:editableImage.CGImage scale:1 orientation:UIImageOrientationUpMirrored] : editableImage ;
}

#pragma mark - Action

- (void)imageDidClicked{
    NSLog(@"点我(⊙v⊙)");
    self.editable = !self.isEditable;
}

- (void)deleteButtonClicked:(UIButton *)button{
    // 删除
    NSLog(@"删除");
    [MBProgressHUD showSuccess:@"不给删(｀・ω・´)"];
    if (self.deleteBlock) {
        self.deleteBlock(self);
    }
}

- (void)reversalButtonClicked:(UIButton *)button{
    // 翻转
    NSLog(@"翻转");
    self.reversal = !self.isReversal;
}

- (void)rotateButtonClicked:(UIButton *)button{
    // 旋转
    NSLog(@"旋转");
}

- (void)restoreButtonClicked:(UIButton *)button{
    // 复原
    NSLog(@"复原");
    self.transform = CGAffineTransformIdentity;
    self.reversal = NO;
}
@end
