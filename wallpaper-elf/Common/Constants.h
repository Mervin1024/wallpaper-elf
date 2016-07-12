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