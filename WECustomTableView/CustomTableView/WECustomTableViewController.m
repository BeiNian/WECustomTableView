



//
//  WECustomTableViewController.m
//  WaterElephantRef
//
//  Created by michael on 2018/10/25.
//  Copyright © 2018年 michael. All rights reserved.
//

#import "WECustomTableViewController.h"
#import <MJRefresh.h>

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
    [self.viewModel addObserver:self forKeyPath:@"dataSource" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)removeDataSourceObserver {
    [self.viewModel removeObserver:self forKeyPath:@"dataSource"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self.tableView reloadData];
    NSLog(@"new %@",[change valueForKey:NSKeyValueChangeNewKey]);
    NSArray *new = [change valueForKey:NSKeyValueChangeNewKey];
    
    if ([[new firstObject] count] == 0) {
        NSLog(@"没有最新数据了");
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer resetNoMoreData];
    }

    
}

#pragma mark - Configure
- (void)configurationTableViewStyle:(UITableViewStyle)style viewModel:(WECustomTableViewModel *)viewModel {
    
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
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - 上下拉刷新事件
/// 上拉事件
- (void)tableViewDidTriggerFooterRefresh {
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        self.viewModel.page += 1;
        [self.viewModel requestRemoteDataCommand:^{
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
}

/// 下拉事件
- (void)tableViewDidTriggerHeaderRefresh {
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        self.viewModel.page = 1;
        [self.viewModel requestRemoteDataCommand:^{
            [self.tableView.mj_header endRefreshing];
        }];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.viewModel.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.viewModel.dataSource[section] count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (self.delegate){
    if ([self.delegate respondsToSelector:@selector(del_tableView:dequeueReusableCellWithIdentifier:forIndexPath:)])
        cell = [self.delegate del_tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    }
    else cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    id object = nil; 
    
    object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    
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
