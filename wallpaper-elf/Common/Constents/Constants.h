//
//  Constants.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/11.
//  Copyright © 2016年 mervin. All rights reserved.
//
#pragma once

// 常用的宏定义 和 常用引用文件
// 写在这里
#import "AppDelegate.h"
#import "NotificationNames.h"
#import "Masonry.h"
#import "Colors.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

#define SYSTEM_FONT(fontSize) [UIFont systemFontOfSize:fontSize]

#define SetBlackBackGroundWhiteForgroundStyle \
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];\
[self.navigationController.navigationBar setBarTintColor:NewBlackColor];\
NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]}; \
[self.navigationController.navigationBar setTitleTextAttributes:textAttributes];\
[[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:0];

#define SetWhiteBackGroundBlackForgroundStyle \
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];\
[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];\
NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]}; \
[self.navigationController.navigationBar setTitleTextAttributes:textAttributes];\
[[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:0];

#define SetBlackBackGroundWhiteForgroundStyleWhenViewWillAppear \
- (void)viewWillAppear:(BOOL)animated\
{\
[super viewWillAppear:animated];\
SetBlackBackGroundWhiteForgroundStyle\
}

#define SetWhiteBackGroundBlackForgroundStyleWhenViewWillAppear \
- (void)viewWillAppear:(BOOL)animated\
{\
[super viewWillAppear:animated];\
SetWhiteBackGroundBlackForgroundStyle\
}\