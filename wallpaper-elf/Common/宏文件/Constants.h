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
#import "Colors.h"
#import "ImageHelper.h"
#import "MobileDevice.h"
#import "ViewHelper.h"

#define WS(weakSelf) __weak typeof(&*self)weakSelf = self;
#define SS(strongSelf, weakSelf) __strong typeof(&*weakSelf)strongSelf = weakSelf;

#define SYSTEM_FONT(fontSize)       [UIFont systemFontOfSize:fontSize]
#define SYSTEM_FONT_BOLD(fontSize)  [UIFont boldSystemFontOfSize:fontSize]

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


#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(format, ...)
#define debugMethod()
#endif
