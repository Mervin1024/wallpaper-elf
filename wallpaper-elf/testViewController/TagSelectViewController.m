//
//  TagSelectViewController.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/15.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "TagSelectViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "HeartClickView.h"

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

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableArray *selectedItems;

@end

@implementation TagSelectViewController

#pragma mark - getter & setter
- (NSArray *)dataSource{
    if (_dataSource.count > 0) {
        return _dataSource;
    }
    NSMutableArray *arr = [NSMutableArray array];
    [self.evaluationTags enumerateObjectsUsingBlock:^(StudentEvaluationTag *tag, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:tag.tagName];
    }];
    return [NSArray arrayWithArray:arr];
}

- (NSArray *)selectedTags{
    NSMutableArray *arr = [NSMutableArray array];
    [self.evaluationTags enumerateObjectsUsingBlock:^(StudentEvaluationTag *tag, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.selectedItems containsObject:tag.tagName]) {
            [arr addObject:tag];
        }
    }];
    return [NSArray arrayWithArray:arr];
}
// 此处应该返回这个界面的高度，用作外部适配
- (CGSize)viewSize{
    return self.view.frame.size;
}

- (NSString *)stringWithTagType{
    NSString *typeStr;
    switch (self.evaluationTagType) {
        case TagTypeBadReviewTeacher:
            typeStr = @"关于老师";
            break;
        case TagTypeCourseReview:
            typeStr = @"关于课程";
            break;
        case TagTypeSystemReview:
            typeStr = @"关于功能";
            break;
    }
    return typeStr;
}
#pragma mark - Initialization

- (instancetype)initWithEvaluationTagType:(StudentEvaluationTagType)evaluationTagType evaluationTags:(NSArray *)evaluationTags{
    if ((self = [super init])) {
        _evaluationTagType = evaluationTagType;
        _evaluationTags = evaluationTags;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedItems = [[NSMutableArray alloc] init];
    [self addCollectionView];
    //    CGSize size = self.collectionView.collectionViewLayout.collectionViewContentSize;
    //    NSLog(@"TagSelectViewController SIZE:%@",NSStringFromCGSize(size));
    //    self.view.frame = CGRectMake(0, 0, size.width, size.height);
    //    self.preferredContentSize = size;
    //    self.view.clipsToBounds = YES;
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
    
    CGSize contentSize =  _collectionView.collectionViewLayout.collectionViewContentSize; // 内容的大小
    self.preferredContentSize = contentSize; // controller 内容大小
    self.view.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    self.view.clipsToBounds = YES; // 边界减掉
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
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, kCollectionViewCellHeight);
    //    cell.titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    
    NSString *text = self.dataSource[indexPath.row];
    cell.titleLabel.text = text;
    
    cell.checked = [self.selectedItems containsObject:text]?YES:NO;
    
    return cell;
}
// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    CollectionViewCell *selectItem = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    selectItem.checked = !selectItem.isChecked;
    if ([self.selectedItems containsObject:selectItem.titleLabel.text]) {
        [self.selectedItems removeObject:selectItem.titleLabel.text];
    } else {
        [self.selectedItems addObject:selectItem.titleLabel.text];
    }
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = [self stringWithTagType];
        
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
    cellWidth = [self checkCellLimitWidth:cellWidth isLimitWidth:nil]; //
    
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

@implementation StudentEvaluationTag

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if ((self = [super init])) {
        self.tagName = dic[@"tagName"];
        self.tagCode = dic[@"tagCode"];
        NSString *tagType = dic[@"tagType"];
        if ([tagType isEqualToString:ONLINE_BAD_REVIEW_TEACHER]) {
            self.tagType = TagTypeBadReviewTeacher;
        }else if ([tagType isEqualToString:ONLINE_COURSE_REVIEW]) {
            self.tagType = TagTypeCourseReview;
        }else if ([tagType isEqualToString:ONLINE_SYSTEM_REVIEW]) {
            self.tagType = TagTypeSystemReview;
        }
    }
    return self;
}

@end
