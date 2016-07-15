//
//  HeartClickView.h
//  boxfish-english
//
//  Created by mervin on 16/7/14.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeartClickView;
@protocol HeartClickViewDelegate <NSObject>

- (void)HeartClickView:(HeartClickView *)heartClickView afterClickIsFilled:(BOOL)filled;

@end

@interface HeartClickView : UIImageView

@property (nonatomic, assign, getter=isFilled) BOOL filled; //默认 NO
@property (nonatomic, assign, getter=isEnabled) BOOL enabled; // 默认 YES
@property (nonatomic, weak) id<HeartClickViewDelegate> delegate;


- (void)showAnimation;
@end
