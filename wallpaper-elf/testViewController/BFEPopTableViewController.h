//
//  ViewController.h
//  woyaofengle
//
//  Created by 李迪 on 16/7/14.
//  Copyright © 2016年 李迪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PopoverBlock)(NSInteger index);

@interface BFEPopTableViewController : UIViewController

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *titleList;

- (instancetype)initWithTitleLists:(NSArray *)titleList andCurrentIndex:(NSInteger)currentIndex andSelected:(PopoverBlock)selected;

@end

