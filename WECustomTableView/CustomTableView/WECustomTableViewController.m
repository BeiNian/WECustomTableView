



//
//  WECustomTableViewController.m
//  WaterElephantRef
//
//  Created by michael on 2018/10/25.
//  Copyright © 2018年 michael. All rights reserved.
//

#import "WECustomTableViewController.h"

@interface WECustomTableViewController ()
 
@end
 
@implementation WECustomTableViewController

#pragma mark -  life cycle
- (void)dealloc {
    // set nil
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    [self removeDataSourceObserver];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - Prive
- (void)addDataSourceObserver {
    [self.viewModel addObserver:self forKeyPath:@"dataSource" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)removeDataSourceObserver {
    [self.viewModel removeObserver:self forKeyPath:@"dataSource"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self.tableView reloadData];
}

#pragma mark - Configure
- (void)configurationTableViewStyle:(UITableViewStyle)style viewModel:(WECustomTableViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self addDataSourceObserver];
    
    if (self.tableView)[self.tableView removeFromSuperview];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    if (self.viewModel.shouldPullDownToRefresh) {
        [self tableViewDidTriggerHeaderRefresh];
    }
    if (self.viewModel.shouldPullUpToLoadMore) {
        [self tableViewDidTriggerFooterRefresh];
    }
    if (style == UITableViewStyleGrouped ) {
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }

}

#pragma mark - 上下拉刷新事件
/// 上拉事件
- (void)tableViewDidTriggerFooterRefresh {
    self.viewModel.page += 1;
    [self.viewModel requestRemoteDataCommand:^{
    }];
}

/// 下拉事件
- (void)tableViewDidTriggerHeaderRefresh {
    self.viewModel.page = 1;
    [self.viewModel requestRemoteDataCommand:^{
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.tableView.style == UITableViewStyleGrouped) {
        return self.viewModel.dataSource.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tableView.style == UITableViewStyleGrouped) {
        return [self.viewModel.dataSource[section] count];
    }
    return self.viewModel.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (self.delegate){
    if ([self.delegate respondsToSelector:@selector(del_tableView:dequeueReusableCellWithIdentifier:forIndexPath:)])
        cell = [self.delegate del_tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    }
    else cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    id object = nil;
    if (self.tableView.style == UITableViewStyleGrouped) object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if (self.tableView.style != UITableViewStyleGrouped) object = self.viewModel.dataSource[indexPath.row];
    
    if (self.delegate){
    if ([self.delegate respondsToSelector:@selector(del_configureCell:atIndexPath:withObject:)])
        [self.delegate del_configureCell:cell atIndexPath:indexPath withObject:object];
    }
    else [self configureCell:cell atIndexPath:indexPath withObject:object];
   
    if (cell) return cell;
    return [UITableViewCell new];
}

#pragma mark - Public
/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

@end
