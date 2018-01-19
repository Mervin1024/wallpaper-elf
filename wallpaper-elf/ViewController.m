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

@interface ViewController (){
    
}

@end

@implementation ViewController{
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemEdit) target:self action:@selector(openTestView:)];
    
}

- (void)openTestView:(id)sender {
//    [self presentViewController:_animationVC animated:YES completion:nil];
}

@end
