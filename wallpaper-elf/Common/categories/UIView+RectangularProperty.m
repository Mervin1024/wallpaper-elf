//
//  UIView+RectangularProperty.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/29.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "UIView+RectangularProperty.h"

@implementation UIView (RectangularProperty)

- (CGSize)size{
    return self.frame.size;
}
- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat)width{
    return self.size.width;
}
- (CGFloat)height{
    return self.size.height;
}
- (CGFloat)originX{
    return self.origin.x;
}
- (CGFloat)originY{
    return self.origin.y;
}


@end
