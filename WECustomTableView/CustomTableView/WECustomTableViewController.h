//
//  WECustomTableViewController.h
//  WaterElephantRef
//
//  Created by michael on 2018/10/25.
//  Copyright © 2018年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WECustomTableViewModel.h" 

@protocol WECustomTableViewControllerDelegate<NSObject>

- (UITableViewCell *)del_tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
/// Override configure cell data
- (void)del_configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end

@interface WECustomTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) WECustomTableViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id delegate;

/// Override Configure
- (void)configurationTableViewStyle:(UITableViewStyle)style viewModel:(WECustomTableViewModel *)viewModell;
/// Override dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
/// Override configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end
