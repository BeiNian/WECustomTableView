//
//  WECustomTableViewModel.m
//  WaterElephantRef
//
//  Created by michael on 2018/10/29.
//  Copyright © 2018年 michael. All rights reserved.
//

#import "WECustomTableViewModel.h"

@implementation WECustomTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];

    }
    return self;
} 

-(void)initialize {
    self.shouldPullUpToLoadMore = YES;
    self.shouldPullDownToRefresh = YES;
    
    self.page = 1;
    self.perPage = 10;
}
-(NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)requestRemoteDataCommand:(void(^)(void))command {
    // 采用此方法赋值，如果如果没有赋值一个空数组
    // [[self mutableArrayValueForKeyPath:@"dataSource"] addObject:array]; 
}

@end
