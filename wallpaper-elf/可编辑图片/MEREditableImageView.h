//
//  MEREditableImageView.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/29.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEREditableImageView;

@interface MEREditableImageView : UIView

@property (nonatomic, copy) void(^deleteBlock)(MEREditableImageView *view); //删除后的回调
@property (nonatomic, assign, getter=isEditable) BOOL editable; // 是否开启可编辑状态

- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithImageName:(NSString *)imageName;

@end
