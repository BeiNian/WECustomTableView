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

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurationTableViewStyle:UITableViewStylePlain viewModel:[OneViewModel new]];
}

/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [OneTableViewCell cellWithTableView:tableView];
}
- (void)configureCell:(OneTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    cell.textLabel.text = (NSString *)object;
}


@end
