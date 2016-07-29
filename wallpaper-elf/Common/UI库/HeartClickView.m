//
//  HeartClickView.m
//  boxfish-english
//
//  Created by mervin on 16/7/14.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "HeartClickView.h"

@interface HeartClickView (){
    UIImageView *heartImageView;
    NSTimer *myAnimatedTimer;
    NSInteger imagesIndex;
}
@property (nonatomic, strong) NSArray *heartAnimationImages;
@end

@implementation HeartClickView

- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, 54, 50)]) {
        self.backgroundColor = NewPurpleColor;
        heartImageView = [[UIImageView alloc] initWithImage:self.heartAnimationImages[0]];
        heartImageView.layer.anchorPoint = CGPointMake(0.525, 0.765);
        heartImageView.center = self.center;
        [self addSubview:heartImageView];
        UITapGestureRecognizer *clickedTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClicked)];
        [heartImageView addGestureRecognizer:clickedTap];
        imagesIndex = 0;
        _filled = NO;
        [self setEnabled:YES];
    }
    return self;
}

#pragma mark - Setter
- (void)setEnabled:(BOOL)enabled{
    _enabled = enabled;
    heartImageView.userInteractionEnabled = enabled ? YES : NO;
}

- (void)setFilled:(BOOL)filled{
    if (filled == _filled) {
        return;
    }
    _filled = filled;
    if (filled) {
        imagesIndex = 0;
        [self animationStart];
    }else{
        heartImageView.image = self.heartAnimationImages[0];
        if ([self.delegate respondsToSelector:@selector(HeartClickView:afterClickIsFilled:)]) {
            [self.delegate HeartClickView:self afterClickIsFilled:self.isFilled];
        }
    }
    
}

- (NSArray *)heartAnimationImages{
    if (_heartAnimationImages.count > 0) {
        return _heartAnimationImages;
    }
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 11; i < 31; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"点赞_000%d",i];
        UIImage *image = [UIImage imageNamed:imageStr];
        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
        [images addObject:image];
    }
    _heartAnimationImages = [images copy];
    return _heartAnimationImages;
}

#pragma mark - Image Helper
// 图片综合处理
- (UIImage *)scaleImage:(UIImage *)image{
    image = [self scaleToSize:image size:CGSizeMake(750, 750)];
    
    CGSize reSize = CGSizeMake(300, 300);
    CGRect myImageRect = CGRectMake(0, 0, reSize.width, reSize.height);
    
    return [self getSubImage:image mCGRect:myImageRect centerBool:YES];
}
// 图片缩放
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
// 图片截取
- (UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool
{
    
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    
    
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth = mCGRect.size.width;
    float viewheight = mCGRect.size.height;
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

#pragma mark - Action
- (void)didClicked{
    if (self.isFilled) {
        [self setFilled:NO];
    }else{
        [self setFilled:YES];
    }
}

#pragma mark - Animation
- (void)animationStart{
    heartImageView.image = self.heartAnimationImages[imagesIndex];
    [self setEnabled:NO];
    myAnimatedTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(setNextImage) userInfo:nil repeats:YES];
}

- (void)setNextImage{
    if (self.isFilled) {
        imagesIndex++;
    }else{
        imagesIndex--;
    }
    heartImageView.image = self.heartAnimationImages[imagesIndex];
    if (imagesIndex == 0 || imagesIndex == self.heartAnimationImages.count - 1) {
        [self animationStop];
    }
}

- (void)animationStop{
    [self setEnabled:YES];
    [myAnimatedTimer invalidate];
    if ([self.delegate respondsToSelector:@selector(HeartClickView:afterClickIsFilled:)]) {
        [self.delegate HeartClickView:self afterClickIsFilled:self.isFilled];
    }
}


@end
