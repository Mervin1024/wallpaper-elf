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
    
    UITapGestureRecognizer *editableTap;
    UIPanGestureRecognizer *movePan;
}

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
    editableTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClicked)];
    movePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidMoved:)];
    [containerView addGestureRecognizer:editableTap];
    
    
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
    if (editable) {
        if (self.superview) {
            [self.superview bringSubviewToFront:self];
        }
        [self addGestureRecognizer:movePan];
    } else {
        [self removeGestureRecognizer:movePan];
    }
    
}

- (void)setReversal:(BOOL)reversal{
    _reversal = reversal;
    containerView.image = reversal ? [UIImage imageWithCGImage:editableImage.CGImage scale:1 orientation:UIImageOrientationUpMirrored] : editableImage ;
}

#pragma mark - Action

- (void)imageDidClicked{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NewImageBecomesTheFirstResponder object:self];
}

- (void)imageDidMoved:(UIPanGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        /*
         让view跟着手指移动
         
         1.获取每次系统捕获到的手指移动的偏移量translation
         2.根据偏移量translation算出当前view应该出现的位置
         3.设置view的新frame
         4.将translation重置为0（十分重要。否则translation每次都会叠加，很快你的view就会移除屏幕！）
         */
        
        CGPoint translation = [gestureRecognizer translationInView:self];
        self.transform = CGAffineTransformTranslate(self.transform, translation.x, translation.y);
        [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self];//  注意一旦你完成上述的移动，将translation重置为0十分重要。否则translation每次都会叠加，很快你的view就会移除屏幕！
    }
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
    self.transform = CGAffineTransformRotate(self.transform, 20);
}

- (void)restoreButtonClicked:(UIButton *)button{
    // 复原
    NSLog(@"复原");
    self.transform = CGAffineTransformIdentity;
    self.reversal = NO;
}
@end
