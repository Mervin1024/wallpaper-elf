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

#define GRAYCOLOR(c) COLOR(c,c,c)
#define BACKGROUND_PINK_COLOR COLOR(255, 236, 238)
#define BACKGROUND_CLEAR_COLOR [UIColor clearColor]
#define BACKGROUND_WHITE_COLOR [UIColor whiteColor]
#define NAVIGATION_TINT_COLOR COLOR(131, 54, 53)

#define LightBlueColor COLOR(21,125,251)
#define LightBlueColor1 COLOR(15, 98, 254)

#define NewBlueColor COLOR(23, 126, 250)
#define NewPurpleColor COLOR(204, 115, 225)
#define NewGrayColor GRAYCOLOR(250)
#define NewYellowColor COLOR(240, 184, 0)
#define AchievementYellowColor COLOR(255, 216, 87)
#define NewBlackColor GRAYCOLOR(50)
#define NewWhiteColor GRAYCOLOR(255)
#define NewYellowBorderColor COLOR(240, 216, 87)

#define RightAnswerItemColor COLOR(102, 177, 50)
#define WrongAnswerItemColor COLOR(255, 39, 18)
