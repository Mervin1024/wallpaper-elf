//
//  HomeViewController.m
//  wallpaper-elf
//
//  Created by mervin on 2016/10/17.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "HomeViewController.h"
#import "MERUITransform.h"
#import "MEREditableImageView.h"
#import "MERUICreator.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    NSMutableArray <MEREditableImageView *> *images;
    NSInteger addedImageNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = COLOR(23, 126, 250);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addEditableImage)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAllResponder)];
    [self.view addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newImageBecomesTheFirstResponder:) name:NewImageBecomesTheFirstResponder object:nil];
    images = [NSMutableArray array];
    addedImageNum = 0;
    [self addEditableImage];
}

- (void)addEditableImage{
    addedImageNum ++;
    MEREditableImageView *view = [[MEREditableImageView alloc] initWithImage:[UIImage imageNamed:@"83146ca0gw1f4o22z0nevj20m80m8gpi"]];
    view.deleteBlock = ^(MEREditableImageView *imageView){
        [images removeObject:imageView];
        [imageView removeFromSuperview];
    };
    view.center = self.view.center;
    view.tag = addedImageNum;
    [self.view addSubview:view];
    [images addObject:view];
}

- (void)removeAllResponder{
    [self changeFirstResponder:nil];
}

- (void)newImageBecomesTheFirstResponder:(NSNotification *)notification{
    [self changeFirstResponder:(MEREditableImageView *)[notification object]];
}

- (void)changeFirstResponder:(MEREditableImageView *)view{
    if (view) {
        for (MEREditableImageView *imgView in images) {
            [imgView setEditable:view.tag == imgView.tag ? !view.isEditable : NO];
        }
    }else {
        for (MEREditableImageView *imgView in images) {
            [imgView setEditable:NO];
        }
    }
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
