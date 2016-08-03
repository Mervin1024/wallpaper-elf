//
//  MERUITransform.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/29.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSUInteger, TransformAnchor) {
//    TransformAnchorCenter,
//    TransformAnchorUpperLeft,
//    TransformAnchorUpperRight,
//    TransformAnchorLowerLeft,
//    TransformAnchorLowerRight
//};

@interface MERUITransform : NSObject

/**
 *	@brief	根据两点获取弧度值
 *
 *	@param 	start 	起点
 *	@param 	end 	终点
 *
 *	@return	弧度值
 */
+ (CGFloat)radianWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;

/**
 *	@brief	根据向量获取弧度值
 *
 *	@param 	vector 	向量
 *
 *	@return	弧度值(-PI ~ PI)
 */
+ (CGFloat)radianWithVector:(CGPoint)vector;

+ (CGFloat)distanceOfStartPoint:(CGPoint)start endPoint:(CGPoint)end;

#pragma mark - frame属性变换
/**
 *	@brief	坐标点变换（位移）
 *
 *	@param 	view 	变换对象
 *	@param 	point 	位移向量
 */
+ (void)view:(UIView *)view pointTransform:(CGPoint)point;
/**
 *	@brief	长宽变换
 *
 *	@param 	view 	变换对象
 *	@param 	x 	横坐标增量
 *	@param 	y 	纵坐标增量
 */
+ (void)view:(UIView *)view addLengthToWidth:(CGFloat)x height:(CGFloat)y;
/**
 *	@brief	默认锚点的等比例变化
 *
 *	@param 	view 	变换对象
 *	@param 	scale 	变换比例
 */
+ (void)view:(UIView *)view scaleTransform:(CGFloat)scale;
/**
 *	@brief	自定义锚点的等比例变化
 *
 *	@param 	view 	变换对象
 *	@param 	scale 	变换比例
 *	@param 	anchor 	锚点（横竖坐标范围0~1）
 */
+ (void)view:(UIView *)view scaleTransform:(CGFloat)scale withTransformAnchor:(CGPoint)anchor;
/**
 *	@brief	默认锚点的非等比例变化
 *
 *	@param 	view 	变换对象
 *	@param 	vector 	变换比例（向量）
 */
+ (void)view:(UIView *)view vectorTransform:(CGPoint)vector;
/**
 *	@brief	自定义锚点的非等比例变化
 *
 *	@param 	view 	变换对象
 *	@param 	vector 	变换比例（向量）
 *	@param 	anchor 	锚点（横竖坐标范围0~1）
 */
+ (void)view:(UIView *)view vectorTransform:(CGPoint)vector withTransformAnchor:(CGPoint)anchor;


@end
