//
//  MERImageHelper.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/16.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MERImageHelper : NSObject

/**
 *	@brief	图片缩放
 *
 *	@param 	img 	原图片
 *	@param 	size 	缩放比例
 *
 *	@return	缩放后的UIImage
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 *	@brief	图片截取
 *
 *	@param 	image 	原图片
 *	@param 	mCGRect 	截取区域
 *	@param 	centerBool 	是否以中心点截取（如果YES，截取区域的origin无效）
 *
 *	@return	截取后图片
 */
+ (UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool;

/**
 *	@brief	创建抗锯齿图像(增加一像素透明边框)
 *
 *	@param 	image 	原图片
 *
 *	@return	抗锯齿处理后图片
 */
+ (UIImage*)antialiasedImage:(UIImage *)image;
@end
