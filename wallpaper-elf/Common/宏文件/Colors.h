//
//  Colors.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/12.
//  Copyright © 2016年 mervin. All rights reserved.
//

#pragma once

#define DefaultLinkColor @"#001cfe"

#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define Color_White     [UIColor whiteColor]        // 1.0 white
#define Color_Black     [UIColor blackColor]        // 0.0 white
#define Color_DarkGray  [UIColor darkGrayColor]     // 0.333 white
#define Color_LightGray [UIColor lightGrayColor]    // 0.667 white
#define Color_Gray      [UIColor grayColor]         // 0.5 white
#define Color_Red       [UIColor redColor]          // 1.0, 0.0, 0.0 RGB
#define Color_Green     [UIColor greenColor]        // 0.0, 1.0, 0.0 RGB
#define Color_Blue      [UIColor blueColor]         // 0.0, 0.0, 1.0 RGB
#define Color_Cyan      [UIColor cyanColor]         // 0.0, 1.0, 1.0 RGB
#define Color_Yellow    [UIColor yellowColor]       // 1.0, 1.0, 0.0 RGB
#define Color_Magenta   [UIColor magentaColor]      // 1.0, 0.0, 1.0 RGB
#define Color_Orange    [UIColor orangeColor]       // 1.0, 0.5, 0.0 RGB
#define Color_Purple    [UIColor purpleColor]       // 0.5, 0.0, 0.5 RGB
#define Color_Brown     [UIColor brownColor]        // 0.6, 0.4, 0.2 RGB
#define Color_Clear     [UIColor clearColor]

#define GRAYCOLOR(c) COLOR(c,c,c)

