//
//  OneViewModel.m
//  WECustomTableView
//
//  Created by michael on 2018/11/7.
//  Copyright © 2018年 michael. All rights reserved.
//

#import "OneViewModel.h"

@implementation OneViewModel
// Override request
- (void)requestRemoteDataCommand:(void(^)(void))command {
    
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
    self.dataSource = [array mutableCopy];
    
}
@end
