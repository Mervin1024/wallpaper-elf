//
//  MEREditableImageView.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/29.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEREditableImageView;
typedef void(^deleteCompleted)(MEREditableImageView *view);

@interface MEREditableImageView : UIView

@property (nonatomic, copy) deleteCompleted deleteBlock;

- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithImageName:(NSString *)imageName;

@end
