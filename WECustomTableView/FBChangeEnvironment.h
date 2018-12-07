//
//  FBChangeEnvironment.h
//  WECustomTableView
//
//  Created by michael on 2018/11/16.
//  Copyright © 2018年 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/***************单例模式宏**************/

#define MACRO_SHARED_INSTANCE_INTERFACE +(instancetype)sharedInstance;

#define MACRO_SHARED_INSTANCE_IMPLEMENTATION(CLASS) \
+(instancetype)sharedInstance \
{ \
static CLASS * sharedInstance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[CLASS alloc] init]; \
}); \
return sharedInstance; \
}

//#define APPDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

NS_ASSUME_NONNULL_BEGIN

@interface FBChangeEnvironment : NSObject 
MACRO_SHARED_INSTANCE_INTERFACE
//切换环境
- (void)changeEnvironment;

//获得当前环境

- (NSString *)currentEnvironment;

@end

NS_ASSUME_NONNULL_END
