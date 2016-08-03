//
//  BFEPopMenuView.h
//  boxfish-english
//
//  Created by 李迪 on 16/7/13.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopoverBlock)(NSInteger index);

@interface BFEPopMenuView : UIView

// 菜单列表集合
@property (nonatomic, copy) NSArray *menuTitles;
// 已选中的item索引
@property (nonatomic, assign) NSInteger currentIndex;

/*!
 *  @author lifution
 *
 *  @brief 显示弹窗
 *
 *  @param aView    箭头指向的控件
 *  @param selected 选择完成回调
 */
- (void)showWithSelected:(PopoverBlock)selected;

@end
