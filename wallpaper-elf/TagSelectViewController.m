//
//  TagSelectViewController.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/15.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "TagSelectViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"

#define kCollectionViewCellsHorizonMargin 15          // cell 之间的间隔
#define kCollectionViewCellHeight 24                  // cell 的高

#define kCollectionViewToLeftMargin 15                // 左
#define kCollectionViewToTopMargin 0                 // 上
#define kCollectionViewToRightMargin 5               // 右
#define kCollectionViewToBottomtMargin  0            // 下

#define kCellTextExtrarMargin 14+14                      // text 额外加的宽度

typedef void (^IsLimitWidth)(BOOL yesORNo,float *data);


static NSString * const kCellIdentifier = @"CellIdentifier"; // Cell 标识
static NSString * const kHeaderViewCellIdentifier = @"HeaderViewCellIdentifier"; // HeadView 标识

@interface TagSelectViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableArray *selectedTags;

@end

@implementation TagSelectViewController

#pragma mark - getter & setter
- (NSArray *)dataSource{
    if (!(self.evaluationItems.count > 0)) {
        return @[@"不够有趣", @"不够温柔", @"讲解不清楚", @"说中文太多",@"热点", @"不够漂亮啊, 下次来个萌妹子", @"反正就是不喜欢这个老师"];
    }
    return [self.evaluationItems copy];
}

- (NSArray *)selectedItems{
    return [NSArray arrayWithArray:self.selectedTags];
}
// 此处应该返回这个界面的高度，用作外部适配
- (CGFloat)viewHeight{
    #warning error
    return 91;

}
#pragma mark - Initialization
- (instancetype)initWithTitle:(NSString *)title evaluations:(NSArray *)evaluations{
    if ((self = [super init])) {
        if (title == nil) {
            title = @"关于老师";
        }
        _evaluationTitle = title;
        _evaluationItems = evaluations;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedTags = [[NSMutableArray alloc] init];
    [self addCollectionView];
    
}

- (void)addCollectionView {
    CGRect collectionViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40);
    UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.allowsMultipleSelection = YES;
    
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.scrollsToTop = NO;
    // self.collectionView.scrollEnabled = NO;
    [self.view addSubview:self.collectionView];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 24);
    cell.titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    
    NSString *text = self.dataSource[indexPath.row];
    cell.titleLabel.text = text;
    
    cell.checked = [self.selectedTags containsObject:text]?YES:NO;
    
    return cell;
}
// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    CollectionViewCell *selectItem = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    selectItem.checked = !selectItem.isChecked;
    if ([self.selectedTags containsObject:selectItem.titleLabel.text]) {
        [self.selectedTags removeObject:selectItem.titleLabel.text];
    } else {
        [self.selectedTags addObject:selectItem.titleLabel.text];
    }
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = self.evaluationTitle;
        
        return (UICollectionReusableView *)headerView;
    }
    return nil;
}


- (float)getCollectionCellWidthText:(NSString *)text {
    float cellWidth;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:13]}];
    
    cellWidth = ceilf(size.width) + kCellTextExtrarMargin;
    cellWidth = [self checkCellLimitWidth:cellWidth isLimitWidth:nil]; // 尝试把 block 实现
  
    return cellWidth;
}


- (float)checkCellLimitWidth:(float)cellWidth isLimitWidth:(IsLimitWidth)isLimitWidth {
    float limitWidth = (CGRectGetWidth(self.collectionView.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth ? isLimitWidth(YES, &cellWidth) : nil; // isLimitWidth block
        return cellWidth;
    }
    isLimitWidth ? isLimitWidth(NO, &cellWidth):nil;
    return cellWidth;
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.dataSource[indexPath.row];
    float cellWidth = [self getCollectionCellWidthText:text];
    return CGSizeMake(cellWidth, kCollectionViewCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kCollectionViewCellsHorizonMargin; // cell之间的间隔
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 38);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 四周边距
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
    // return UIEdgeInsetsMake(0, 0, 0, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
