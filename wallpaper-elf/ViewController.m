//
//  ViewController.m
//  wallpaper-elf
//
//  Created by mervin on 16/7/15.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "ViewController.h"
#import "MERUITransform.h"
#import "MEREditableImageView.h"
#import "MERUICreator.h"
#import "LayerAnimationViewController.h"

@interface ViewController (){
    LayerAnimationViewController *_animationVC;
}

@end

@implementation ViewController{
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _animationVC = [[LayerAnimationViewController alloc] init];
    [self.navigationController pushViewController:_animationVC animated:YES];
}

@end
