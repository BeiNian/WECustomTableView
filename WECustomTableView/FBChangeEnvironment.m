//
//  FBChangeEnvironment.m
//  WECustomTableView
//
//  Created by michael on 2018/11/16.
//  Copyright © 2018年 michael. All rights reserved.
//

#import "FBChangeEnvironment.h"
#import "AppDelegate.h"


//UAT
static NSString *const devConfig = @"0";
//预生产
static NSString *const prodConfig = @"1";
//生产
static NSString *const prodConfig1 = @"2";

@implementation FBChangeEnvironment


MACRO_SHARED_INSTANCE_IMPLEMENTATION(FBChangeEnvironment)

//切换环境

- (void)changeEnvironment{
    
    NSLog(@"change environment start");
    NSString *title=@"切换环境";
    
    NSString *subTitle=@"重启后生效, 非测试人员请点击cancel";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:UIAlertControllerStyleActionSheet];
    //修改title
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, alertControllerStr.length)];
    
    [alert setValue:alertControllerStr forKey:@"attributedTitle"];
    //修改message
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:subTitle];
    
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, alertControllerMessageStr.length)];
    
    [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    
    
    NSString *currentEnvironment=@"";
    
    if ([[self currentEnvironment] isEqualToString:devConfig]) {
        
        currentEnvironment=@"当前环境为 UAT";
        [alert addAction:[UIAlertAction actionWithTitle:@"UAT" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            //测试环境
            
            [[NSUserDefaults standardUserDefaults] setObject:devConfig forKey:@"serverFB"];
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"预生产" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //预生产环境
            [[NSUserDefaults standardUserDefaults] setObject:prodConfig forKey:@"serverFB"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"生产" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //生产环境
            [[NSUserDefaults standardUserDefaults] setObject:prodConfig1 forKey:@"serverFB"];
        }]];
    } else if ([[self currentEnvironment] isEqualToString:prodConfig]) {
        
        currentEnvironment=@"当前环境为 预生产";
        
        [alert addAction:[UIAlertAction actionWithTitle:@"UAT" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //测试环境
            [[NSUserDefaults standardUserDefaults] setObject:devConfig forKey:@"serverFB"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"预生产" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //预生产环境
            [[NSUserDefaults standardUserDefaults] setObject:prodConfig forKey:@"serverFB"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"生产" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //生产环境
            [[NSUserDefaults standardUserDefaults] setObject:prodConfig1 forKey:@"serverFB"];
        }]];
        
    } else if ([[self currentEnvironment] isEqualToString:prodConfig1]) {
        currentEnvironment=@"当前环境为 生产";
        [alert addAction:[UIAlertAction actionWithTitle:@"UAT" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //测试环境
            [[NSUserDefaults standardUserDefaults] setObject:devConfig forKey:@"serverFB"];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"预生产" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //预生产环境
            [[NSUserDefaults standardUserDefaults] setObject:prodConfig forKey:@"serverFB"];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"生产" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //生产环境
            [[NSUserDefaults standardUserDefaults] setObject:prodConfig1 forKey:@"serverFB"];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    //当前选择的视图控制器需要自己赋值，比如tabbar的didSelectViewController里
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.window.rootViewController presentViewController:alert animated:YES completion:^{
        
        
    }];
    
}

//获得当前环境

- (NSString *)currentEnvironment{
    
    //默认生产环境
    
    NSString *currentEnvironment=prodConfig1;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"serverFB"]) {
        
        currentEnvironment = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverFB"];
        
    } 
    return currentEnvironment;
}



@end
