//
//  MobileDevice.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/27.
//  Copyright © 2016年 mervin. All rights reserved.
//

#pragma once

#define IPAD        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPHONE      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_BOUNDS       ([UIScreen mainScreen].bounds)
#define SCREEN_SIZE         ([UIScreen mainScreen].bounds.size)
#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)