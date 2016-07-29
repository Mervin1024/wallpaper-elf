
// Copyright (c) 2014 Giovanni Lodi
//


#import <UIKit/UIKit.h>

@interface UICollectionViewLeftAlignedLayout : UICollectionViewFlowLayout

@end

/**
 *  Just a convenience protocol to keep things consistent.
 *  Someone could find it confusing for a delegate object to conform to UICollectionViewDelegateFlowLayout
 *  while using UICollectionViewLeftAlignedLayout.
 */
@protocol UICollectionViewDelegateLeftAlignedLayout <UICollectionViewDelegateFlowLayout>

@end

extern float CYLFilterHeaderViewHeigt;

@interface CollectionHeaderView : UICollectionReusableView

@property (nonatomic,strong)UILabel * titleLabel;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *selectedImage;
@property (assign, nonatomic, getter=isChecked) BOOL checked;

@end