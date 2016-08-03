//
//  ViewController.m
//  woyaofengle
//
//  Created by 李迪 on 16/7/14.
//  Copyright © 2016年 李迪. All rights reserved.
//

#import "BFEPopTableViewController.h"

@interface BFEPopTableViewController () <UITableViewDelegate, UITableViewDataSource> {
    UIView *_blankView;
    UITableView *_tableView;
}

@property (nonatomic, copy) PopoverBlock block;

@end

@implementation BFEPopTableViewController

- (instancetype)initWithTitleLists:(NSArray *)titleList andCurrentIndex:(NSInteger)currentIndex andSelected:(PopoverBlock)selected{
    if (self = [super init]) {
        _titleList = titleList;
        _currentIndex = currentIndex;
        if (selected) {
            _block = selected;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    self.preferredContentSize = CGSizeMake(244, _titleList.count*60+60);
}

- (void)creatTableView {
    _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    _blankView.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 244, _titleList.count*60+60) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = _blankView;
    _tableView.tableFooterView = _blankView;
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropDownMenuCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DropDownMenuCell"];
    }
    [cell.textLabel setTextAlignment: NSTextAlignmentCenter];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _titleList[indexPath.row];
    if ([NSIndexPath indexPathForRow:_currentIndex inSection:0] == indexPath) {
        cell.textLabel.textColor = [UIColor colorWithRed:240/255.0f green:184/255.0f blue:1/255.0f alpha:1];
        cell.backgroundColor = [UIColor clearColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_block) {
        _block(indexPath.row);
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
    self.currentIndex = indexPath.row;
    [_tableView reloadRowsAtIndexPaths:@[oldIndexPath,indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
