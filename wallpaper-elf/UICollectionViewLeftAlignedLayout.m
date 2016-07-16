
// Copyright (c) 2014 Giovanni Lodi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "UICollectionViewLeftAlignedLayout.h"
#import "Masonry.h"
#import "MERUICreator.h"

#pragma mark - UICollectionViewLayoutAttributes

@interface UICollectionViewLayoutAttributes (LeftAligned)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset;

@end

@implementation UICollectionViewLayoutAttributes (LeftAligned)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset
{
    CGRect frame = self.frame;
    frame.origin.x = sectionInset.left;
    self.frame = frame;
}

@end

#pragma mark - UICollectionViewLeftAlignedLayout

@implementation UICollectionViewLeftAlignedLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    UIEdgeInsets sectionInset = [self evaluatedSectionInsetForItemAtIndex:indexPath.section];

    BOOL isFirstItemInSection = indexPath.item == 0;
    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - sectionInset.left - sectionInset.right;

    if (isFirstItemInSection) {
        [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset];
        return currentItemAttributes;
    }

    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    CGRect currentFrame = currentItemAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(sectionInset.left,
                                              currentFrame.origin.y,
                                              layoutWidth,
                                              currentFrame.size.height);
    // if the current frame, once left aligned to the left and stretched to the full collection view
    // widht intersects the previous frame then they are on the same line
    BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);

    if (isFirstItemInRow) {
        // make sure the first item on a line is left aligned
        [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset];
        return currentItemAttributes;
    }

    CGRect frame = currentItemAttributes.frame;
    frame.origin.x = previousFrameRightPoint + [self evaluatedMinimumInteritemSpacingForItemAtIndex:indexPath.row];
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}

- (CGFloat)evaluatedMinimumInteritemSpacingForItemAtIndex:(NSInteger)index
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateLeftAlignedLayout> delegate = (id<UICollectionViewDelegateLeftAlignedLayout>)self.collectionView.delegate;

        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:index];
    } else {
        return self.minimumInteritemSpacing;
    }
}

- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateLeftAlignedLayout> delegate = (id<UICollectionViewDelegateLeftAlignedLayout>)self.collectionView.delegate;

        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    } else {
        return self.sectionInset;
    }
}

@end

#pragma mark - CollectionHeaderView

float CYLFilterHeaderViewHeigt = 38;

@implementation CollectionHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self headViewInit];
    }
    return self;
}

- (id)headViewInit {
    // self.backgroundColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0];
    UIView *yellowSmallIcon = [UIView new];
    yellowSmallIcon.backgroundColor = COLOR(255, 204, 36);
    self.titleLabel = [MERUICreator createLabel:@"关于老师" color:GRAYCOLOR(102) font:SYSTEM_FONT(18)];
    [self addSubview:yellowSmallIcon];
    [self addSubview:self.titleLabel];
    WS(ws);
    [yellowSmallIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 16));
        make.left.mas_equalTo(ws).offset(15);
        make.top.mas_equalTo(ws).offset(1);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yellowSmallIcon.mas_right).offset(5);
        make.top.mas_equalTo(ws);
    }];
    return self;
}

@end

#pragma mark - CollectionViewCell

@implementation CollectionViewCell
- (void)setChecked:(BOOL)checked{
    _checked = checked;
    self.layer.borderWidth = checked ? 0 : 0.5;
    _selectedImage.hidden = !checked;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}
- (id)sharedInit {
    [self setup];
    return self;
}

- (void)setup {
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = SYSTEM_FONT(12);
    
    self.layer.borderColor = GRAYCOLOR(204).CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 4.0;
    
    // 选中时 image
    UIImage *image = [UIImage imageNamed:@"selectedBackground.png"];
    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 17, 17) resizingMode:UIImageResizingModeStretch];
    
    _selectedImage = [UIImageView new];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:_selectedImage];
    
    WS(ws);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.contentView).insets(UIEdgeInsetsMake(4, 14, 6, 14));
    }];
    [_selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.contentView);
    }];
    _selectedImage.image = image;
    
    [self setChecked:NO];
}
@end

