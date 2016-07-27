//
//  MERImageHelper.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/16.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MERImageHelper : NSObject


// 图片缩放
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
// 图片截取
+ (UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool;
@end
