//
//  ImageHelper.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/15.
//  Copyright © 2016年 mervin. All rights reserved.
//

#pragma once

#define CGImageGet(UIImage)         (__bridge id)UIImage.CGImage
#define CGImageRefGet(UIImage)      UIImage.CGImage