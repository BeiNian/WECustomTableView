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

- (void)requestRemoteDataCommand:(void(^)(void))command {}

@end
