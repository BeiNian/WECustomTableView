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
    
    if (command) {
        command();
    }
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
        NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
        [[self mutableArrayValueForKeyPath:@"dataSource"] addObject:array];
//        self.dataSource = array;
    }else {
        NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
//        NSMutableArray *arrm = [NSMutableArray array];
//        for (NSString *str in self.dataSource) {
//            [arrm addObject:str];
//        }
//        for (NSString *str in array) {
//            [arrm addObject:str];
//        }
//        if (self.page >= 3) {
//            self.dataSource = array;
//        } else {
//            self.dataSource = arrm;
//        }
        if (self.page >= 3) {
            
            [[self mutableArrayValueForKeyPath:@"dataSource"] addObject:[NSArray array]];
            return;
        }
        [[self mutableArrayValueForKeyPath:@"dataSource"] addObject:array];
    }
    
    
    
    
}
@end
