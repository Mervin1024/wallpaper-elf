//
//  BFEPopMenuView.m
//  boxfish-english
//
//  Created by 李迪 on 16/7/13.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFEPopMenuView.h"

// 字体大小
#define kPopoverFontSize 18.f


@interface BFEPopMenuView () <UITableViewDelegate, UITableViewDataSource>
{
    PopoverBlock _selectedBlock;
    UIView *_backgroundView;
    UIView *_blankView;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong, readonly) NSIndexPath *currentIndexPath;
@end

@implementation BFEPopMenuView

- (instancetype)init
{
    if (!(self = [super init])) return nil;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)dealloc{
    
}

#pragma mark -- getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _blankView.backgroundColor = [UIColor whiteColor];
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 52;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = _blankView;
        _tableView.tableFooterView = _blankView;
        _tableView.layer.cornerRadius  = 6.f;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kPopoverCellIdentifier"];
    }
    return _tableView;
}

- (NSIndexPath *)currentIndexPath{
    if (self.currentIndex == NSNotFound) {
        return nil;
    }
    return [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
}

#pragma mark -- delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kPopoverCellIdentifier"];
    cell.textLabel.font   = [UIFont systemFontOfSize:kPopoverFontSize];
    cell.textLabel.text   = [self.menuTitles objectAtIndex:indexPath.row];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    if (self.currentIndexPath == indexPath) {
        cell.textLabel.textColor = [UIColor colorWithRed:240/255.0f green:184/255.0f blue:1/255.0f alpha:1];
        cell.backgroundColor = [UIColor clearColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedBlock) {
        _selectedBlock(indexPath.row);
    }
    self.currentIndex = indexPath.row;
    [self.tableView reloadData];
    [self hide];
}

#pragma mark -- Animation
// 显示动画
- (void)show{
    _backgroundView.alpha = 0;
    self.alpha = 0;
    self.transform = CGAffineTransformMakeTranslation(0, 5);
    [UIView animateWithDuration:0.15 animations:^{
        _backgroundView.alpha = 0.4;
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
// 隐藏动画
- (void)hide{
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeTranslation(0, 5);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
        [self removeFromSuperview];
    }];
}

#pragma mark -- public

/*!
 *  @author lifution
 *
 *  @brief 显示弹窗
 *
 *  @param selected 选择完成回调
 */
- (void)showWithSelected:(PopoverBlock)selected
{
    if (selected) _selectedBlock = selected;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _backgroundView = [[UIView alloc] init];
    _backgroundView.frame = keyWindow.bounds;
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    _backgroundView.userInteractionEnabled = YES;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    [keyWindow addSubview:_backgroundView];
    
    // 刷新数据更新contentSize
    [self.tableView reloadData];
    
    // 取得标题中的最大宽度
    CGFloat maxWidth = 0;
    for (id obj in self.menuTitles) {
        if ([obj isKindOfClass:[NSString class]]) {
            CGSize titleSize = [obj sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kPopoverFontSize]}];
            if (titleSize.width > maxWidth) {
                maxWidth = titleSize.width;
            }
        }
    }
    CGFloat curWidth = ((maxWidth+130)>SCREEN_WIDTH-30)?(SCREEN_WIDTH-30):(maxWidth+130);
    CGFloat curHeight = self.menuTitles.count*52+52;
    CGFloat curX = SCREEN_WIDTH/2-curWidth/2;
    CGFloat curY = SCREEN_HEIGHT/2-curHeight/2+32;
    
    self.frame = CGRectMake(curX, curY, curWidth, curHeight);
    self.tableView.frame = CGRectMake(0, 0, curWidth, curHeight);
    [self addSubview:self.tableView];
    [keyWindow addSubview:self];
    
    [self show];
}

@end
