//
//  WECustomTableViewModel.h
//  WaterElephantRef
//
//  Created by michael on 2018/10/29.
//  Copyright © 2018年 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WECustomTableViewModel : NSObject
 
@property (nonatomic, strong) NSMutableArray *dataSource;
/// 需要支持下来刷新 defalut is NO
@property (nonatomic, readwrite, assign) BOOL shouldPullDownToRefresh;
/// 需要支持上拉加载 defalut is NO
@property (nonatomic, readwrite, assign) BOOL shouldPullUpToLoadMore;

/// 当前页 defalut is 1
@property (nonatomic, readwrite, assign) NSUInteger page;
/// 每一页的数据 defalut is 10
@property (nonatomic, readwrite, assign) NSUInteger perPage;

// Override request
-(void)initialize;
// Override request
- (void)requestRemoteDataCommand:(void(^)(void))command;


@end
