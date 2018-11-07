//
//  OneViewController.m
//  WECustomTableView
//
//  Created by michael on 2018/11/7.
//  Copyright © 2018年 michael. All rights reserved.
//

#import "OneViewController.h"
#import "OneTableViewCell.h"
#import "OneViewModel.h"

@interface OneViewController ()<WECustomTableViewControllerDelegate>
@property (nonatomic, strong) WECustomTableViewController *viewcontroller;

@end

@implementation OneViewController

- (void)extracted {
    [self.viewcontroller configurationTableViewStyle:UITableViewStylePlain viewModel:[OneViewModel new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewcontroller = [WECustomTableViewController new];
    self.viewcontroller.delegate = self;
    [self extracted];
    [self addChildViewController:self.viewcontroller];
    [self.view addSubview:self.viewcontroller.view];
}

/// dequeueReusableCell  WECustomTableViewControllerDelegate
- (UITableViewCell *)del_tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [OneTableViewCell cellWithTableView:tableView];
}
- (void)del_configureCell:(OneTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    cell.textLabel.text = (NSString *)object;
}


@end
