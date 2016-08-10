//
//  HeartBeatView.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/16.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "HeartBeatView.h"
#import "MERImageHelper.h"

@interface HeartBeatView (){
    
}

@property (nonatomic, copy) NSArray *heartAnimationImages;

@end

@implementation HeartBeatView{
//    UIImageView *animationView;
    NSTimer *myAnimatedTimer;
    NSInteger imagesIndex;
}

- (instancetype)init{
    if (self = [super initWithImage:self.heartAnimationImages[0]]) {
//        self.backgroundColor = NewYellowColor;
//        animationView = [[UIImageView alloc] initWithImage:self.heartAnimationImages[0]];
//        animationView.center = self.center;
//        [self addSubview:animationView];
//        animationView.animationImages = images;
//        animationView.animationDuration = 1.0;
//        animationView.animationRepeatCount = 1;
//        animationView.hidden = YES;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animationStart)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (NSArray *)heartAnimationImages{
    if (_heartAnimationImages.count > 0) {
        return _heartAnimationImages;
    }
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 11; i < 31; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"点赞_000%d",i];
        UIImage *image = [self scaleImage:[UIImage imageNamed:imageStr]];
        [images addObject:image];
    }
    _heartAnimationImages = [images copy];
    return _heartAnimationImages;
}

- (UIImage *)scaleImage:(UIImage *)image{
    image = [MERImageHelper scaleToSize:image size:CGSizeMake(750, 750)];
    
    CGSize reSize = CGSizeMake(300, 300);
    CGRect myImageRect = CGRectMake(0, 0, reSize.width, reSize.height);

    return [MERImageHelper getSubImage:image mCGRect:myImageRect centerBool:YES];
}

- (void)animationStart{
    imagesIndex = 0;
    myAnimatedTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(setNextImage) userInfo:nil repeats:YES];

}

- (void)setNextImage{
    if (imagesIndex == self.heartAnimationImages.count - 1) {
        [self animationStop];
    }else{
        imagesIndex++;
        self.image = self.heartAnimationImages[imagesIndex];
    }
    
}

- (void)animationStop{
    [myAnimatedTimer invalidate];
    myAnimatedTimer = nil;
}

- (void)dealloc{
    NSLog(@"释放了！");
}

@end


